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

#include <boost/dynamic_bitset/dynamic_bitset.hpp>

#include "Log.h"
#include "ObjectMgr.h"
#include "WaypointMovementGenerator.h"
#include "ObjectAccessor.h"
#include "ScriptedCreature.h"
#include "TemporarySummon.h"

/*
 *  Aradne, Agatha, Arthura, Daschla
 */
enum eDEATHKNELL_VALKYRS
{
    NPC_AGATHA = 49044,
    NPC_DASCHLA = 49128,
    NPC_ARTHURA = 49129,
    NPC_ARADNE = 50372,
    NPC_ARADNE_RISEN_DEAD = 50374,
    NPC_UNDERTAKER_MORDO = 1568,
    NPC_RISEN_RECRUIT = 50414,

    /* Agatha Intro Quest for players */
    QUEST_FRESH_OUT_OF_THE_GRAVE = 24959,
    SPELL_RIGOR_MORTIS = 73523,
    SPELL_VALKYR_RESURRECTION = 73524,

    /* ARADNE Pathing Data */
    PATH_ARADNE = 192759,
    WP_ARADNE_TRIGGER_1 = 0, // DB point 1
    WP_ARADNE_TRIGGER_2 = 10, // DB point 11
    WP_ARADNE_TRIGGER_3 = 15, // DB point 16
    WP_ARADNE_TRIGGER_4 = 16, // DB point 17

    /* creature_text group ids */
    TEXT_ARADNE_1 = 0,
    TEXT_ARADNE_2 = 1,
    TEXT_ARADNE_3 = 2,

    TEXT_RISEN_DEAD_1 = 0,
    TEXT_RISEN_DEAD_2 = 1,
    TEXT_RISEN_DEAD_3 = 2,
    TEXT_RISEN_DEAD_4 = 3,
    TEXT_RISEN_DEAD_5 = 4,
    TEXT_RISEN_DEAD_6 = 5,

    TEXT_RISEN_RECRUIT_THANKS = 0,

    POINT_RISEN_TO_MORDO = 100,
    TALK_PAUSE_MS = 2500
};

enum RisenOutcome
{
    RISEN_OUTCOME_RECRUIT = 0,
    RISEN_OUTCOME_ZOMBIE = 1,
    RISEN_OUTCOME_DIE = 2
};

struct AradneTriggerData
{
    uint32 TriggerId;
    uint8 AradneTextGroup;
    float SummonX;
    float SummonY;
    float SummonZ;
    float SummonO;
};

static const AradneTriggerData AradneTriggerTable[] =
{
    {
        WP_ARADNE_TRIGGER_1, TEXT_ARADNE_1, 1695.4567f, 1681.1476f, 134.9969f,
        0.0f
    },
    {
        WP_ARADNE_TRIGGER_2, TEXT_ARADNE_2, 1683.0104f, 1687.0764f, 137.9393f,
        0.0f
    },
    {
        WP_ARADNE_TRIGGER_3, TEXT_ARADNE_3, 1707.4567f, 1703.7379f, 134.9806f,
        0.0f
    },
    {
        WP_ARADNE_TRIGGER_4, TEXT_ARADNE_2, 1696.5365f, 1688.5817f, 135.4182f,
        0.0f
    }
};

class npc_deathknell_valkyr : public CreatureScript
{
public:
    npc_deathknell_valkyr() : CreatureScript("npc_deathknell_valkyr")
    {
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_deathknell_valkyrAI(creature);
    }

    struct npc_deathknell_valkyrAI : public ScriptedAI
    {
        npc_deathknell_valkyrAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        TaskScheduler _scheduler;
        bool _aradnePathStarted = false;

        void ApplyValkyrVisualState()
        {
            me->SetAIAnimKitId(Anim::ANIM_FLY);
            me->SetMovementAnimKitId(Anim::ANIM_FLY);
            me->SetByteFlag(UNIT_FIELD_BYTES_1, UNIT_BYTES_1_OFFSET_ANIM_TIER,
                            UNIT_BYTE1_FLAG_ALWAYS_STAND |
                            UNIT_BYTE1_FLAG_HOVER);

            if (me->GetEntry() == NPC_AGATHA && !me->HasAura(49414))
                me->CastSpell(me, 49414, true);
        }

        void Reset() override
        {
            _scheduler.CancelAll();
            ApplyValkyrVisualState();

            if (me->GetEntry() == NPC_ARADNE)
                StartAradnePath();
        }

        void EnterEvadeMode(EvadeReason /*why*/) override
        {
            ScriptedAI::EnterEvadeMode();
            ApplyValkyrVisualState();

            if (me->GetEntry() == NPC_ARADNE)
                StartAradnePath();
        }

        void UpdateAI(uint32 diff) override
        {
            _scheduler.Update(diff);
            ApplyValkyrVisualState();
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (me->GetEntry() != NPC_ARADNE)
                return;

            if (type != WAYPOINT_MOTION_TYPE)
                return;

            switch (pointId)
            {
            case 0:
            case 10:
            case 15:
            case 16:
                HandleAradneWaypointTrigger(pointId);
                break;
            default:
                break;
            }

            ApplyValkyrVisualState();
        }

    private:
        void PauseActorForTalk(Creature* actor, uint32 duration)
        {
            if (!actor || !actor->IsAlive())
                return;

            actor->SetFacingToObject(me);
            actor->StopMoving();
            actor->SetControlled(true, UNIT_STATE_ROOT);

            ObjectGuid guid = actor->GetGUID();
            _scheduler.Schedule(Milliseconds(duration),
                                [this, guid](TaskContext /*task*/)
                                {
                                    if (Creature* target =
                                        ObjectAccessor::GetCreature(*me, guid))
                                    {
                                        if (!target->IsAlive())
                                            return;

                                        target->SetControlled(
                                            false, UNIT_STATE_ROOT);

                                        /*if (!target->GetMotionMaster()->empty())
                                            if (auto move =
                                                dynamic_cast<
                                                    WaypointMovementGenerator<
                                                        Creature>*>(target->
                                                    GetMotionMaster()->top()))
                                                move->GetTrackerTimer().
                                                    Reset(1); */
                                    }
                                });
        }

        const AradneTriggerData* GetTriggerData(uint32 pointId) const
        {
            for (const AradneTriggerData& data : AradneTriggerTable)
                if (data.TriggerId == pointId)
                    return &data;

            return nullptr;
        }

        uint8 SelectRisenDeadTextGroup() const
        {
            return urand(TEXT_RISEN_DEAD_1, TEXT_RISEN_DEAD_6);
        }

        RisenOutcome GetOutcomeForTextGroup(uint8 textGroup) const
        {
            switch (textGroup)
            {
            case TEXT_RISEN_DEAD_1:
            case TEXT_RISEN_DEAD_2:
            case TEXT_RISEN_DEAD_3:
                return RISEN_OUTCOME_RECRUIT;
            case TEXT_RISEN_DEAD_5:
                return RISEN_OUTCOME_DIE;
            case TEXT_RISEN_DEAD_4:
            case TEXT_RISEN_DEAD_6:
            default:
                return RISEN_OUTCOME_ZOMBIE;
            }
        }

        void StartAradnePath()
        {
            if (!me->IsAlive())
                return;

            _aradnePathStarted = true;
            me->GetMotionMaster()->MovePath(PATH_ARADNE, true);
        }

        void StartZombieSequence(Creature* risen)
        {
            if (!risen || !risen->IsAlive())
                return;

            risen->SetReactState(REACT_PASSIVE);
            risen->SetWalk(false);
            risen->GetMotionMaster()->MoveRandom(6.0f);
            risen->DespawnOrUnsummon(5000);
        }

        void StartInstantDeathSequence(Creature* risen)
        {
            if (!risen || !risen->IsAlive())
                return;

            risen->KillSelf();
        }

        void StartRecruitSequence(Creature* risen)
        {
            if (!risen || !risen->IsAlive())
                return;

            Creature* mordo = me->FindNearestCreature(
                NPC_UNDERTAKER_MORDO, 50.0f, true);
            if (!mordo)
            {
                StartZombieSequence(risen);
                return;
            }

            float spawnX = risen->GetPositionX();
            float spawnY = risen->GetPositionY();
            float spawnZ = risen->GetPositionZ();
            float spawnO = risen->GetOrientation();

            float mordoX = mordo->GetPositionX();
            float mordoY = mordo->GetPositionY();
            float mordoZ = mordo->GetPositionZ();
            float mordoO = mordo->GetOrientation();

            risen->DespawnOrUnsummon();

            if (TempSummon* recruit = me->SummonCreature(
                NPC_RISEN_RECRUIT,
                spawnX, spawnY, spawnZ, spawnO,
                TEMPSUMMON_TIMED_DESPAWN,
                12000))
            {
                recruit->SetWalk(true);
                recruit->SetReactState(REACT_PASSIVE);

                recruit->GetMotionMaster()->MovePoint(
                    POINT_RISEN_TO_MORDO, mordoX, mordoY, mordoZ);

                ObjectGuid recruitGuid = recruit->GetGUID();

                _scheduler.Schedule(Milliseconds(2800),
                                    [this, recruitGuid, mordoO](
                                    TaskContext /*task*/)
                                    {
                                        Creature* risenRecruit =
                                            ObjectAccessor::GetCreature(
                                                *me, recruitGuid);
                                        Creature* mordo = me->
                                            FindNearestCreature(
                                                NPC_UNDERTAKER_MORDO, 15.0f,
                                                true);
                                        if (!risenRecruit || !risenRecruit->
                                            IsAlive() || !mordo || !mordo->
                                            IsAlive())
                                            return;

                                        risenRecruit->SetFacingToObject(mordo);
                                        mordo->SetFacingToObject(risenRecruit);

                                        PauseActorForTalk(
                                            risenRecruit, TALK_PAUSE_MS);

                                        if (risenRecruit->AI())
                                            risenRecruit->AI()->Talk(
                                                TEXT_RISEN_RECRUIT_THANKS);
                                    });

                _scheduler.Schedule(Milliseconds(2800 + TALK_PAUSE_MS),
                                    [this, recruitGuid](TaskContext /*task*/)
                                    {
                                        if (Creature* risenRecruit =
                                            ObjectAccessor::GetCreature(
                                                *me, recruitGuid))
                                            if (risenRecruit->IsAlive())
                                                risenRecruit->GetMotionMaster()
                                                    ->MoveRandom(4.0f);
                                    });

                _scheduler.Schedule(Milliseconds(2800 + TALK_PAUSE_MS + 3000),
                                    [this, recruitGuid](TaskContext /*task*/)
                                    {
                                        if (Creature* risenRecruit =
                                            ObjectAccessor::GetCreature(
                                                *me, recruitGuid))
                                            risenRecruit->DespawnOrUnsummon(
                                                1000);
                                    });
            }
        }

        void HandleAradneWaypointTrigger(uint32 pointId)
        {
            const AradneTriggerData* data = GetTriggerData(pointId);
            if (!data)
                return;

            PauseActorForTalk(me, TALK_PAUSE_MS);
            me->SetFacingTo(me->GetAngle(data->SummonX, data->SummonY));
            Talk(data->AradneTextGroup);
            me->CastSpell(me, SPELL_VALKYR_RESURRECTION, false);

            uint8 risenTextGroup = SelectRisenDeadTextGroup();
            RisenOutcome outcome = GetOutcomeForTextGroup(risenTextGroup);

            _scheduler.Schedule(Milliseconds(250),
                                [this, data, risenTextGroup, outcome](
                                TaskContext /*task*/)
                                {
                                    if (!me->IsAlive())
                                        return;

                                    if (TempSummon* risen = me->SummonCreature(
                                        NPC_ARADNE_RISEN_DEAD,
                                        data->SummonX, data->SummonY,
                                        data->SummonZ, data->SummonO,
                                        TEMPSUMMON_TIMED_DESPAWN,
                                        12000))
                                    {
                                        risen->SetReactState(REACT_PASSIVE);
                                        risen->SetWalk(true);

                                        me->SetFacingToObject(risen);
                                        risen->SetFacingToObject(me);

                                        PauseActorForTalk(risen, TALK_PAUSE_MS);

                                        ObjectGuid risenGuid = risen->GetGUID();

                                        _scheduler.Schedule(
                                            Milliseconds(200),
                                            [this, risenGuid, risenTextGroup](
                                            TaskContext /*task2*/)
                                            {
                                                if (Creature* risenDead =
                                                    ObjectAccessor::GetCreature(
                                                        *me, risenGuid))
                                                    if (risenDead->IsAlive() &&
                                                        risenDead->AI())
                                                        risenDead->AI()->Talk(
                                                            risenTextGroup);
                                            });

                                        _scheduler.Schedule(
                                            Milliseconds(TALK_PAUSE_MS),
                                            [this, risenGuid, outcome](
                                            TaskContext /*task2*/)
                                            {
                                                Creature* risenDead =
                                                    ObjectAccessor::GetCreature(
                                                        *me, risenGuid);
                                                if (!risenDead || !risenDead->
                                                    IsAlive())
                                                    return;

                                                switch (outcome)
                                                {
                                                case RISEN_OUTCOME_RECRUIT:
                                                    StartRecruitSequence(
                                                        risenDead);
                                                    break;
                                                case RISEN_OUTCOME_ZOMBIE:
                                                    StartZombieSequence(
                                                        risenDead);
                                                    break;
                                                case RISEN_OUTCOME_DIE:
                                                    StartInstantDeathSequence(
                                                        risenDead);
                                                    break;
                                                }
                                            });
                                    }
                                });

            ApplyValkyrVisualState();
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature,
                       const Quest* quest) override
    {
        if (creature->GetEntry() == NPC_AGATHA &&
            quest->GetQuestId() == QUEST_FRESH_OUT_OF_THE_GRAVE &&
            player->GetAura(SPELL_RIGOR_MORTIS))
        {
            creature->CastSpell(player, SPELL_VALKYR_RESURRECTION, true);
            player->RemoveAura(SPELL_RIGOR_MORTIS);
        }

        return true;
    }
};

enum ShadowGraveConstants
{
    QUEST_THE_SHADOW_GRAVE = 28608,
    NPC_DARNELL = 49141,

    SAY_GREETING = 0,
    SAY_THIS_WAY = 1,
    SAY_SEARCH_1 = 2,
    SAY_SEARCH_2 = 3,
    SAY_HELP = 4,
    SAY_SEARCH_3 = 5,

    POINT_STAIR_1 = 1,
    POINT_STAIR_2 = 2,
    POINT_LAST = 3,
    POINT_FINISH = 4,

    POINT_SEARCH_1 = 10,
    POINT_SEARCH_2 = 11,

    EVENT_START_SEARCH = 1,
    EVENT_CONTINUE_SEARCH = 2,
    EVENT_SEARCH_TEXT_2 = 3,
    EVENT_SEARCH_TEXT_3 = 4,
    EVENT_DESPAWN_SELF = 5
};

static const Position DarnellSpawnPos =
{
    1690.56299f, 1674.60596f, 135.42439f, 2.2959971f
};

static const Position TriggerAnchorEntrance =
{
    1661.239990f, 1662.859985f, 142.587997f, 0.0f
};

static const Position TriggerAnchorStair1 =
{
    1642.693237f, 1663.235352f, 132.477509f, 0.0f
};

static const Position TriggerAnchorStair2 =
{
    1642.760010f, 1677.719971f, 126.931999f, 0.0f
};

static const Position TriggerAnchorFinish =
{
    1657.310059f, 1677.939941f, 123.772003f, 0.0f
};

static const Position DarnellSearchPoints[] =
{
    {1664.9171f, 1663.8660f, 120.719559f, 0.0f},
    {1657.2613f, 1688.4189f, 120.802002f, 0.0f},
    {1672.5812f, 1670.4755f, 120.802002f, 0.0f},
    {1664.4927f, 1693.7637f, 120.802002f, 0.0f},
};

class npc_darnell_shadow_grave : public CreatureScript
{
public:
    npc_darnell_shadow_grave() : CreatureScript("npc_darnell_shadow_grave")
    {
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_darnell_shadow_graveAI(creature);
    }

    struct npc_darnell_shadow_graveAI : public ScriptedAI
    {
        npc_darnell_shadow_graveAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        enum DarnellState
        {
            STATE_IDLE,
            STATE_FOLLOW_PLAYER,
            STATE_STAIRS,
            STATE_SEARCHING,
            STATE_DESPAWNING
        };

        ObjectGuid _playerGuid;
        DarnellState _state = STATE_IDLE;

        uint32 _currentPointId = POINT_FINISH;
        uint32 _checkTimer = 250;

        bool _pendingMove = false;
        uint32 _pendingPointId = POINT_FINISH;
        Position _pendingPos;

        EventMap _events;
        uint8 _searchIndex = 0;
        bool _despawnScheduled = false;

        void Reset() override
        {
            _events.Reset();
            _playerGuid.Clear();

            _state = STATE_IDLE;
            _currentPointId = POINT_FINISH;
            _checkTimer = 250;

            _pendingMove = false;
            _pendingPointId = POINT_FINISH;
            _searchIndex = 0;
            _despawnScheduled = false;

            me->SetReactState(REACT_PASSIVE);
            me->SetWalk(false);
        }

        void SetGUID(ObjectGuid guid, int32 /*id*/) override
        {
            if (!guid || !guid.IsPlayer())
                return;

            _playerGuid = guid;
            _state = STATE_FOLLOW_PLAYER;
            StartFollowPlayer();
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_START_SEARCH:
                    StartSearchRoute();
                    break;
                case EVENT_CONTINUE_SEARCH:
                    ContinueSearchRoute();
                    break;
                case EVENT_SEARCH_TEXT_2:
                    Talk(SAY_SEARCH_2);
                    break;
                case EVENT_SEARCH_TEXT_3:
                    Talk(SAY_SEARCH_3);
                    break;
                case EVENT_DESPAWN_SELF:
                    me->DespawnOrUnsummon();
                    break;
                default:
                    break;
                }
            }

            if (_pendingMove)
            {
                _pendingMove = false;
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(
                    _pendingPointId, _pendingPos, true);
                return;
            }

            if (_checkTimer > diff)
            {
                _checkTimer -= diff;
                return;
            }

            _checkTimer = 250;

            // Despawn if player logged out / no longer exists
            Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid);
            if (!player)
            {
                if (!_despawnScheduled)
                {
                    _despawnScheduled = true;
                    _state = STATE_DESPAWNING;

                    me->StopMoving();
                    me->GetMotionMaster()->Clear();
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_DESPAWN_SELF, 1);
                }
                return;
            }

            // Despawn if quest has been turned in / rewarded
            if (!_despawnScheduled && player->GetQuestRewardStatus(
                QUEST_THE_SHADOW_GRAVE))
            {
                _despawnScheduled = true;
                _state = STATE_DESPAWNING;

                me->StopMoving();
                me->GetMotionMaster()->Clear();
                _events.Reset();
                _events.ScheduleEvent(EVENT_DESPAWN_SELF, 1000);
                return;
            }

            if (_state == STATE_FOLLOW_PLAYER)
            {
                if (player->IsAlive() &&
                    player->IsWithinDist3d(
                        TriggerAnchorEntrance.GetPositionX(),
                        TriggerAnchorEntrance.GetPositionY(),
                        TriggerAnchorEntrance.GetPositionZ(),
                        3.0f))
                {
                    StartStairs();
                }
            }
        }

        void MovementInform(uint32 type, uint32 pointId) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (_state == STATE_STAIRS)
            {
                if (pointId != _currentPointId)
                    return;

                AdvanceStairs(pointId);
                return;
            }

            if (_state == STATE_SEARCHING)
            {
                if (pointId != _currentPointId)
                    return;

                OnSearchPointReached(pointId);
            }
        }

    private:
        void StartFollowPlayer()
        {
            if (Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid))
            {
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveFollow(player, 1.0f, 0.0f);
            }
        }

        void StartStairs()
        {
            _events.Reset();

            me->GetMotionMaster()->Clear();
            me->StopMoving();

            _state = STATE_STAIRS;
            Talk(SAY_THIS_WAY);

            QueueMove(POINT_STAIR_1, TriggerAnchorStair1);
            _currentPointId = POINT_STAIR_1;
        }

        void AdvanceStairs(uint32 pointId)
        {
            switch (pointId)
            {
            case POINT_STAIR_1:
                QueueMove(POINT_STAIR_2, TriggerAnchorStair2);
                _currentPointId = POINT_STAIR_2;
                break;

            case POINT_STAIR_2:
                QueueMove(POINT_LAST, TriggerAnchorFinish);
                _currentPointId = POINT_LAST;
                break;

            case POINT_LAST:
                me->StopMoving();
                me->GetMotionMaster()->Clear();
                _events.ScheduleEvent(EVENT_START_SEARCH, 800);
                _currentPointId = POINT_FINISH;
                break;

            default:
                break;
            }
        }

        void StartSearchRoute()
        {
            _state = STATE_SEARCHING;
            _searchIndex = 0;

            Talk(SAY_SEARCH_1);
            MoveToSearchIndex(_searchIndex);
        }

        void MoveToSearchIndex(uint8 index)
        {
            uint32 pointId = POINT_SEARCH_1 + index;
            QueueMove(pointId, DarnellSearchPoints[index]);
            _currentPointId = pointId;
        }

        void OnSearchPointReached(uint32 pointId)
        {
            me->StopMoving();
            me->GetMotionMaster()->Clear();

            switch (pointId)
            {
            case POINT_SEARCH_1:
                _events.ScheduleEvent(EVENT_SEARCH_TEXT_2, 500);
                break;
            case POINT_SEARCH_2:
                _events.ScheduleEvent(EVENT_SEARCH_TEXT_3, 500);
                break;
            default:
                break;
            }

            _events.ScheduleEvent(EVENT_CONTINUE_SEARCH, 3000);
        }

        void ContinueSearchRoute()
        {
            if (_state != STATE_SEARCHING)
                return;

            Player* player = ObjectAccessor::GetPlayer(*me, _playerGuid);
            if (!player)
            {
                if (!_despawnScheduled)
                {
                    _despawnScheduled = true;
                    _state = STATE_DESPAWNING;

                    me->StopMoving();
                    me->GetMotionMaster()->Clear();
                    _events.Reset();
                    _events.ScheduleEvent(EVENT_DESPAWN_SELF, 1);
                }
                return;
            }

            if (!_despawnScheduled && player->GetQuestRewardStatus(
                QUEST_THE_SHADOW_GRAVE))
            {
                _despawnScheduled = true;
                _state = STATE_DESPAWNING;

                me->StopMoving();
                me->GetMotionMaster()->Clear();
                _events.Reset();
                _events.ScheduleEvent(EVENT_DESPAWN_SELF, 1000);
                return;
            }

            ++_searchIndex;
            if (_searchIndex >= 4)
                _searchIndex = 0;

            MoveToSearchIndex(_searchIndex);
        }

        void QueueMove(uint32 pointId, const Position& pos)
        {
            _pendingPointId = pointId;
            _pendingPos = pos;
            _pendingMove = true;
        }
    };
};

class npc_undertaker_mordo_shadow_grave : public CreatureScript
{
public:
    npc_undertaker_mordo_shadow_grave() : CreatureScript(
        "npc_undertaker_mordo_shadow_grave")
    {
    }

    bool OnQuestAccept(Player* player, Creature* creature,
                       const Quest* quest) override
    {
        if (!player || !creature || !quest)
            return false;

        if (quest->GetQuestId() != QUEST_THE_SHADOW_GRAVE)
            return false;

        if (Creature* darnell = creature->SummonCreature(
            NPC_DARNELL,
            DarnellSpawnPos,
            TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,
            300000))
        {
            darnell->SetReactState(REACT_PASSIVE);
            darnell->SetWalk(false);

            if (darnell->AI())
            {
                darnell->AI()->SetGUID(player->GetGUID());
                darnell->AI()->Talk(SAY_GREETING, player);
            }
        }

        return false;
    }
};


void AddSC_tirisfal_glades()
{
    new npc_deathknell_valkyr();
    new npc_darnell_shadow_grave();
    new npc_undertaker_mordo_shadow_grave();
}
