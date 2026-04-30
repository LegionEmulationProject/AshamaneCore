/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_dk_".
 */

#include "ScriptMgr.h"
#include "CellImpl.h"
#include "CombatAI.h"
#include "GridNotifiersImpl.h"
#include "MotionMaster.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"

enum DeathKnightSpells
{
    SPELL_DK_SUMMON_GARGOYLE_1      = 49206,
    SPELL_DK_SUMMON_GARGOYLE_2      = 50514,
    SPELL_DK_DISMISS_GARGOYLE       = 50515,
    SPELL_DK_SANCTUARY              = 54661,
    NPC_DK_ARMY_OF_THE_DEAD_GHOUL   = 24207,
};

class npc_pet_dk_ebon_gargoyle : public CreatureScript
{
    public:
        npc_pet_dk_ebon_gargoyle() : CreatureScript("npc_pet_dk_ebon_gargoyle") { }

        struct npc_pet_dk_ebon_gargoyleAI : CasterAI
        {
            npc_pet_dk_ebon_gargoyleAI(Creature* creature) : CasterAI(creature) { }

            void InitializeAI() override
            {
                CasterAI::InitializeAI();
                ObjectGuid ownerGuid = me->GetOwnerGUID();
                if (!ownerGuid)
                    return;

                // Find victim of Summon Gargoyle spell
                std::list<Unit*> targets;
                Trinity::AnyUnfriendlyUnitInObjectRangeCheck u_check(me, me, 30.0f);
                Trinity::UnitListSearcher<Trinity::AnyUnfriendlyUnitInObjectRangeCheck> searcher(me, targets, u_check);
                Cell::VisitAllObjects(me, searcher, 30.0f);
                for (std::list<Unit*>::const_iterator iter = targets.begin(); iter != targets.end(); ++iter)
                    if ((*iter)->HasAura(SPELL_DK_SUMMON_GARGOYLE_1, ownerGuid))
                    {
                        me->Attack((*iter), false);
                        break;
                    }
            }

            void JustDied(Unit* /*killer*/) override
            {
                // Stop Feeding Gargoyle when it dies
                if (Unit* owner = me->GetOwner())
                    owner->RemoveAurasDueToSpell(SPELL_DK_SUMMON_GARGOYLE_2);
            }

            // Fly away when dismissed
            void SpellHit(Unit* source, SpellInfo const* spell) override
            {
                if (spell->Id != SPELL_DK_DISMISS_GARGOYLE || !me->IsAlive())
                    return;

                Unit* owner = me->GetOwner();
                if (!owner || owner != source)
                    return;

                // Stop Fighting
                me->ApplyModFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE, true);

                // Sanctuary
                me->CastSpell(me, SPELL_DK_SANCTUARY, true);
                me->SetReactState(REACT_PASSIVE);

                //! HACK: Creature's can't have MOVEMENTFLAG_FLYING
                // Fly Away
                me->SetCanFly(true);
                me->SetSpeedRate(MOVE_FLIGHT, 0.75f);
                me->SetSpeedRate(MOVE_RUN, 0.75f);
                float x = me->GetPositionX() + 20 * std::cos(me->GetOrientation());
                float y = me->GetPositionY() + 20 * std::sin(me->GetOrientation());
                float z = me->GetPositionZ() + 40;
                me->GetMotionMaster()->Clear(false);
                me->GetMotionMaster()->MovePoint(0, x, y, z);

                // Despawn as soon as possible
                me->DespawnOrUnsummon(Seconds(4));
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_pet_dk_ebon_gargoyleAI(creature);
        }
};

class npc_pet_dk_army_of_the_dead_ghoul : public CreatureScript
{
public:
    npc_pet_dk_army_of_the_dead_ghoul() : CreatureScript("npc_pet_dk_army_of_the_dead_ghoul") { }

    struct npc_pet_dk_army_of_the_dead_ghoulAI : ScriptedAI
    {
        npc_pet_dk_army_of_the_dead_ghoulAI(Creature* creature) : ScriptedAI(creature) { }

        float _followAngle = PET_FOLLOW_ANGLE;
        uint32 _followCheckTimer = 500;

        Unit* GetOwner() const
        {
            return me->GetOwner();
        }

        uint8 GetArmySlot(Unit* owner) const
        {
            if (!owner)
                return 0;

            std::list<TempSummon*> armyGhouls;
            owner->GetAllMinionsByEntry(armyGhouls, NPC_DK_ARMY_OF_THE_DEAD_GHOUL);

            std::vector<TempSummon*> sortedGhouls;
            sortedGhouls.reserve(armyGhouls.size());

            for (TempSummon* ghoul : armyGhouls)
            {
                if (!ghoul)
                    continue;

                sortedGhouls.push_back(ghoul);
            }

            std::sort(sortedGhouls.begin(), sortedGhouls.end(),
                [](TempSummon* left, TempSummon* right)
                {
                    return left->GetGUID().GetCounter() < right->GetGUID().GetCounter();
                });

            TempSummon* self = me->ToTempSummon();
            auto itr = std::find(sortedGhouls.begin(), sortedGhouls.end(), self);

            if (itr != sortedGhouls.end())
                return uint8(std::distance(sortedGhouls.begin(), itr) % 8);

            return 0;
        }

        void RefreshFollowAngle()
        {
            Unit* owner = GetOwner();
            if (!owner)
                return;

            constexpr uint8 MAX_ARMY_GHOUL_SLOTS = 8;
            constexpr float angleStep = float((2.0f * M_PI) / MAX_ARMY_GHOUL_SLOTS);

            uint8 slot = GetArmySlot(owner);
            _followAngle = PET_FOLLOW_ANGLE + (angleStep * slot);

            if (me->HasUnitTypeMask(UNIT_MASK_MINION))
            {
                if (TempSummon* tempSummon = me->ToTempSummon())
                {
                    Minion* minion = static_cast<Minion*>(tempSummon);
                    minion->SetFollowAngle(_followAngle);
                }
            }
        }

        void MoveToOwnerSwarmPosition()
        {
            Unit* owner = GetOwner();
            if (!owner)
                return;

            if (me->IsInCombat() || me->GetVictim())
                return;

            RefreshFollowAngle();

            me->GetMotionMaster()->Clear(false);
            me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, _followAngle, MOTION_SLOT_ACTIVE);
        }

        void InitializeAI() override
        {
            ScriptedAI::InitializeAI();

            me->SetReactState(REACT_AGGRESSIVE);

            me->GetScheduler().Schedule(Milliseconds(100), [](TaskContext context)
            {
                Unit* unit = context.GetUnit();
                if (!unit)
                    return;

                Creature* ghoul = unit->ToCreature();
                if (!ghoul)
                    return;

                if (npc_pet_dk_army_of_the_dead_ghoulAI* ai = CAST_AI(npc_pet_dk_army_of_the_dead_ghoulAI, ghoul->AI()))
                    ai->MoveToOwnerSwarmPosition();
            });
        }

        void UpdateAI(uint32 diff) override
        {
            if (UpdateVictim())
            {
                DoMeleeAttackIfReady();
                return;
            }

            if (_followCheckTimer <= diff)
            {
                MoveToOwnerSwarmPosition();
                _followCheckTimer = 500;
            }
            else
                _followCheckTimer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_pet_dk_army_of_the_dead_ghoulAI(creature);
    }
};

void AddSC_deathknight_pet_scripts()
{
    new npc_pet_dk_ebon_gargoyle();
    new npc_pet_dk_army_of_the_dead_ghoul();
}
