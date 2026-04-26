/*
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2008-2026 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2025-2026 Legion Emulation Project <https://github.com/LegionEmulationProject/>
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
#include "ScriptMgr.h"

enum MageArtifactChoice
{
    PLAYER_CHOICE_MAGE_SELECTION    = 265,
    PLAYER_CHOICE_RESPONSE_ARCANE   = 584,
    PLAYER_CHOICE_RESPONSE_FIRE     = 585,
    PLAYER_CHOICE_RESPONSE_FROST    = 586,   
};

enum MageQuests
{
    QUEST_ARCANE_CHOSEN = 44307,
    QUEST_FIRE_CHOSEN = 44308,
    QUEST_FROST_CHOSEN = 44309,

    QUEST_FELSTORMS_PLEA = 41035,
    QUEST_THE_DREADLORDS_PRIZE = 41036,
    QUEST_A_MAGES_WEAPON = 41085,
    QUEST_A_SECOND_WEAPON = 43441,
    QUEST_THRICE_THE_POWER = 44310,
    
    QUEST_ALUNETH_GREATSTAFF_OF_THE_MAGNA = 42001,

    QUEST_AN_UNEXPECTED_MESSAGE = 40267,
    QUEST_THE_PATH_OF_ATONEMENT = 40270,
    QUEST_A_THE_FROZEN_FLAME = 11997,

    QUEST_FINDING_EBONCHILL = 42452,
    QUEST_THE_DEADWIND_SITE = 42476,
    QUEST_DAIO_THE_DECREPIT = 42477,
    QUEST_THE_MAGE_HUNTER = 42479,
    QUEST_ALODIS_GEMS = 42455,

    QUEST_THE_TIRISGARDE_REBORN = 41124,
};

enum MageCreatureIds
{
    NPC_MERYL_FELSTORM = 102700,
    NPC_ALODI          = 102846,
};

enum MageEtc
{
    CONVERSATION_THE_DREADLORDS_PRIZE_END = 1281,
    SPELL_TELE_TO_THE_DREADLORDS_PRIZE = 203241,
};

void AddSC_zone_orderhall_mage()
{
}
