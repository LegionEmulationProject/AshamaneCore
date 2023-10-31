/*
 * Copyright (C) 2008-2023 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2017-2023 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2022-2023 Legion Emulation Project <https://github.com/LegionEmulationProject>
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

#include "Conversation.h"
#include "Chat.h"
#include "GameObject.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "PhasingHandler.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "SpellScript.h"

enum LegionIntroSkip
{
    QUEST_BLINK_OF_AN_EYE = 44663,
    SPELL_PLAY_DALARAN_TELEPORTATION_SCENE = 227861,
};

#define GOSSIP_MENU_OPTION "I've heard this tale before... <Skip the Legion introductory quests and begin your journey in Dalaran.>"

class npc_recruter_lee : public CreatureScript
{
public:
    npc_recruter_lee() : CreatureScript("npc_recruter_lee") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->IsQuestGiver())
        {
            player->PrepareQuestMenu(creature->GetGUID());
        }

        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GOSSIP_MENU_OPTION, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 0, "Are you sure you want to skip?", 0, false);
        SendGossipMenuFor(player, player->GetGossipTextId(creature), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*Sender*/, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 0)
        {
            if (player->GetQuestStatus(QUEST_BLINK_OF_AN_EYE) == QUEST_STATUS_NONE)
            {
                if (const Quest* quest = sObjectMgr->GetQuestTemplate(QUEST_BLINK_OF_AN_EYE))
                    player->AddQuest(quest, nullptr);
                PhasingHandler::OnConditionChange(player);
                CloseGossipMenuFor(player);
                player->CastSpell(player, SPELL_PLAY_DALARAN_TELEPORTATION_SCENE);
                return true;
            }
        }
        return true;
    }
};

void AddSC_stormwind_city()
{
    new npc_recruter_lee();
}
