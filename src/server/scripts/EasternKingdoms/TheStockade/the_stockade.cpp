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
#include "the_stockade.h"

class npc_petty_criminal : public CreatureScript
{
public:
    npc_petty_criminal() : CreatureScript("npc_petty_criminal") { }

    struct npc_petty_criminalAI : public ScriptedAI
    {
        npc_petty_criminalAI(Creature* creature) : ScriptedAI(creature) { }

        UnitStandStateType HomeStandState;

        void InitializeAI() override
        {
            ScriptedAI::InitializeAI();
            HomeStandState = me->GetStandState();
        }

        void Reset() override
        {
            HomeStandState = me->GetStandState();
            me->SetStandState(HomeStandState);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            if (!UpdateVictim())
                return;

            if (me->GetStandState() != UNIT_STAND_STATE_STAND)
                me->SetStandState(UNIT_STAND_STATE_STAND);

            DoMeleeAttackIfReady();
        }

        void JustReachedHome() override
        {
            me->SetStandState(HomeStandState);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            me->SetStandState(HomeStandState);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_petty_criminalAI(creature);
    }
};

void AddSC_the_stockade()
{
    new npc_petty_criminal();
}
