/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 * This file is part of the Legion Emulation Project. See AUTHORS file for Copyright information
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

#include "Creature.h"
#include "CreatureAI.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "ObjectMgr.h"
#include "PhasingHandler.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum AssaultOnTheDarkPortalQuests
{
   QUEST_AZEROTHS_LAST_STAND           = 35933,
   QUEST_ONSLAUGHTS_END                = 34392,
   QUEST_THE_PORTALS_POWER             = 34393,
};

enum AssaultOnTheDarkPortalEvents
{
    EVENT_KHADGAR_SAY_THIRD_LINE,
};

enum AssaultOnTheDarkPortalTexts
{
    SAY_KHADGAR_FIRST_LINE   = 0,
    SAY_KHADGAR_SECOND_LINE  = 1,
    SAY_KHADGAR_THIRD_LINE   = 2,
    SAY_KHADGAR_FOURTH_LINE  = 3,
    SAY_KHADGAR_FIFTH_LINE   = 4,
};

enum AssaultOnTheDarkPortalQuestObjectives
{
    OBJECTIVE_NORTHERN_SPIRE_DISABLED   = 272621,
    OBJECTIVE_SOUTHERN_SPIRE_DISABLED   = 273946,

	OBJECTIVE_BURNING_BLADE_DESTROYED   = 273438,
	OBJECTIVE_SHATTERED_HAND_DESTROYED  = 273556,
	OBJECTIVE_BLACKROCK_MARK_DESTROYED  = 273557,

    OBJECTIVE_ENTER_GULDANS_PRISON      = 273930,
};

enum AssaultOnTheDarkPortalScenes
{
   SCENE_CHOGALL_FREED                 = 961,
   SCENE_TERRONGOR_FREED               = 962,
   SCENE_GULDAN_FREED                  = 808,
};

class npc_archmage_khadgar_78558 : public CreatureScript
{
    public:
        npc_archmage_khadgar_78558() : CreatureScript("npc_archmage_khadgar_78558") {}

            bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
            {
                if (npc_archmage_khadgar_78558AI* khadgar = CAST_AI(npc_archmage_khadgar_78558AI, creature->AI()))

                switch (quest->GetQuestId())
                {
                    case QUEST_AZEROTHS_LAST_STAND:
                            khadgar->Talk(SAY_KHADGAR_FIRST_LINE, player);
                        break; 
                    case QUEST_THE_PORTALS_POWER:
                            khadgar->Talk(SAY_KHADGAR_FIFTH_LINE);
                        break;
                    default:
                        break;
                }
                return true;
            }
    		    
        struct npc_archmage_khadgar_78558AI : public ScriptedAI
        {
            npc_archmage_khadgar_78558AI(Creature* creature) : ScriptedAI(creature) {}

            EventMap events;
    
            void DoAction(int32 action) override
		    {
			    switch (action)
			    {
				    case OBJECTIVE_NORTHERN_SPIRE_DISABLED:
                        Talk(SAY_KHADGAR_SECOND_LINE);
                        events.ScheduleEvent(EVENT_KHADGAR_SAY_THIRD_LINE, 3s);
					    break;
				    default:
					    break;
			    }
		    }



            void UpdateAI(const uint32 diff) override
		    {
		    	events.Update(diff);
            
		    	while (uint32 eventId = events.ExecuteEvent())
		    	{
		    		switch (eventId)
		    		{
                        case EVENT_KHADGAR_SAY_THIRD_LINE:
                            Talk(SAY_KHADGAR_THIRD_LINE);
                            break;
                        default:
                            break;
                    }
                }
            }

        };
    
        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_archmage_khadgar_78558AI(creature);
        }
};

enum OnSlaughtsEnd
{
    SPELL_THAELIN_EVENT_AURA = 164677,
    SPELL_HANSEL_EVENT_AURA = 167689,

    SAY_THAELIN_FIRST_LINE = 0,
    SAY_HANSEL_FIRST_LINE = 0,

    SCENE_DETONATION = 937,
};

class npc_thaelin_darkanvil_78568 : public CreatureScript
{
    public:
        npc_thaelin_darkanvil_78568() : CreatureScript("npc_thaelin_darkanvil_78568") {}
    
        struct npc_thaelin_darkanvil_78568AI : public ScriptedAI
        {
            npc_thaelin_darkanvil_78568AI(Creature* creature) : ScriptedAI(creature) { }

            bool eventTriggered;
    
            void MoveInLineOfSight(Unit* unit) override
            {
                if (Player* player = unit->ToPlayer())
                {
                    if (!me->IsWithinDistInMap(player, 15.0f))
                        return;

                    if (!eventTriggered)
                    {
                        if (player->GetQuestStatus(QUEST_ONSLAUGHTS_END) == QUEST_STATUS_INCOMPLETE)
                        {
                            eventTriggered = true;
                            Talk(SAY_THAELIN_FIRST_LINE, player);
                            player->GetSceneMgr().PlaySceneByPackageId(SCENE_DETONATION);
                        }
                    }
                }
            }
        };
    
        CreatureAI* GetAI(Creature* p_Creature) const override
        {
            return new npc_thaelin_darkanvil_78568AI(p_Creature);
        }
};

class npc_hansel_heavyhands_78569 : public CreatureScript
{
    public:
        npc_hansel_heavyhands_78569() : CreatureScript("npc_hansel_heavyhands_78569") {}
    
        struct npc_hansel_heavyhands_78569AI : public ScriptedAI
        {
            npc_hansel_heavyhands_78569AI(Creature* creature) : ScriptedAI(creature) { }

            bool eventTriggered;
    
            void MoveInLineOfSight(Unit* unit) override
            {
                if (Player* player = unit->ToPlayer())
                {
                    if (!me->IsWithinDistInMap(player, 15.0f))
                        return;

                    if (!eventTriggered)
                    {
                        if (player->GetQuestStatus(QUEST_ONSLAUGHTS_END) == QUEST_STATUS_INCOMPLETE)
                        {
                            eventTriggered = true;
                            Talk(SAY_HANSEL_FIRST_LINE, player);
                            player->GetSceneMgr().PlaySceneByPackageId(SCENE_DETONATION);
                        }
                    }
                }
            }
        };
    
        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_hansel_heavyhands_78569AI(creature);
        }
};

// QuestId: 34392
struct quest_onslaughts_end : public QuestScript
{
public:
    quest_onslaughts_end() : QuestScript("quest_onslaughts_end") { }

    void OnQuestObjectiveChange(Player* player, Quest const* quest, QuestObjective const& objective, int32 /*oldAmount*/, int32 /*newAmount*/)
    { 
        switch (objective.ID)
        {
            case OBJECTIVE_NORTHERN_SPIRE_DISABLED:
                player->GetSceneMgr().PlaySceneByPackageId(SCENE_CHOGALL_FREED);
                break;

            case OBJECTIVE_SOUTHERN_SPIRE_DISABLED:
                player->GetSceneMgr().PlaySceneByPackageId(SCENE_TERRONGOR_FREED);
                break;

            default:
                return;
        
        }
    }
};

enum PortalsPower
{
    ACTION_GULDAN_SAY_SECOND_LINE,
    ACTION_GULDAN_SAY_THIRD_LINE,
    ACTION_GULDAN_SAY_FOURTH_LINE,

    EVENT_GULDAN_SAY_FIRST_LINE,

    NPC_GULDAN = 78333,

    SAY_GULDAN_FIRST_LINE = 0,
    SAY_GULDAN_SECOND_LINE = 1,
    SAY_GULDAN_THIRD_LINE = 2,
    SAY_GULDAN_FOURTH_LINE = 3,

    SPELL_SCENE_GULDAN_REVEAL   = 163807,
    SPELL_PORTAL_CREDIT         = 166319,
};

 // Gul'dan 78333 
class npc_guldan_78333 : public CreatureScript
{
public:
    npc_guldan_78333() : CreatureScript("npc_guldan_78333") { }

    struct npc_guldan_78333AI : public ScriptedAI
    {
        npc_guldan_78333AI(Creature* creature) : ScriptedAI(creature) { }

        bool sceneTriggered = false;
        EventMap events;

        void MoveInLineOfSight(Unit* who) override
        {
            Player* player = who->ToPlayer();
            if (!player)
                return;

            if (player->GetDistance2d(me) >= 40.0f)
                return;

            if (player->GetPositionZ() - 5.0f > me->GetPositionZ())
                return;

            if (player->GetQuestStatus(QUEST_THE_PORTALS_POWER) == QUEST_STATUS_NONE)
                return;

            if (player->GetQuestObjectiveCounter(OBJECTIVE_ENTER_GULDANS_PRISON) > 1)
                return;

            if (!sceneTriggered)
            {
                player->CastSpell(player, SPELL_SCENE_GULDAN_REVEAL);
                player->CastSpell(player, SPELL_PORTAL_CREDIT);
                sceneTriggered = true;
                events.ScheduleEvent(EVENT_GULDAN_SAY_FIRST_LINE, 12s);
            }
        }

        void DoAction(int32 action) override
        {
            switch (action)
            {
                case ACTION_GULDAN_SAY_SECOND_LINE:
                    Talk(SAY_GULDAN_SECOND_LINE);
                    break;
                case ACTION_GULDAN_SAY_THIRD_LINE:
                    Talk(SAY_GULDAN_THIRD_LINE);
                    break;
                case ACTION_GULDAN_SAY_FOURTH_LINE:
                    Talk(SAY_GULDAN_FOURTH_LINE);
                    break;
            }
        }

        void UpdateAI(uint32 const diff) override
        {
            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_GULDAN_SAY_FIRST_LINE:
                    Talk(SAY_GULDAN_FIRST_LINE);
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_guldan_78333AI(creature);
    }
};

struct quest_portals_power : public QuestScript
{
public:
    quest_portals_power() : QuestScript("quest_portals_power") { }

    void OnQuestObjectiveChange(Player* player, Quest const* /*quest*/, QuestObjective const& objective, int32 /*oldAmount*/, int32 /*newAmount*/)
    {
        switch (objective.ID)
        {
            case OBJECTIVE_BURNING_BLADE_DESTROYED:
                if (Creature* guldan = player->FindNearestCreature(NPC_GULDAN, 50.0f))
                guldan->AI()->DoAction(ACTION_GULDAN_SAY_SECOND_LINE);
                break;
            case OBJECTIVE_SHATTERED_HAND_DESTROYED:
                if (Creature* guldan = player->FindNearestCreature(NPC_GULDAN, 50.0f))
                guldan->AI()->DoAction(ACTION_GULDAN_SAY_THIRD_LINE);
                break;
            case OBJECTIVE_BLACKROCK_MARK_DESTROYED:
                if (Creature* guldan = player->FindNearestCreature(NPC_GULDAN, 50.0f))
                guldan->AI()->DoAction(ACTION_GULDAN_SAY_FOURTH_LINE);
                break;
            default:
                break;
        }
    }

    void OnQuestComplete(Player* player, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_THE_PORTALS_POWER)
            player->GetSceneMgr().PlaySceneByPackageId(SCENE_GULDAN_FREED);
    }
};

/// 237670/237667 - Dark Portal
class go_platform_tanaan : public GameObjectScript
{
public:
    go_platform_tanaan() : GameObjectScript("go_platform_tanaan") { }

    struct go_platform_tanaanAI : public GameObjectAI
    {
        go_platform_tanaanAI(GameObject* gameObject) : GameObjectAI(gameObject) { }

        void InitializeAI()
        {
            if (!go)
                return;

            go->SetGoState(GO_STATE_ACTIVE);
            go->SetLootState(GO_ACTIVATED);
        }
    };

    GameObjectAI* GetAI(GameObject* gameObject) const override
    {
        return new go_platform_tanaanAI(gameObject);
    }
};


void AddSC_assault_on_the_dark_portal()
{
    new npc_archmage_khadgar_78558();
    new npc_thaelin_darkanvil_78568();
    new npc_hansel_heavyhands_78569();
    new quest_onslaughts_end();
    new npc_guldan_78333();
    new quest_portals_power();
    new go_platform_tanaan();
}