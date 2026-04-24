/*
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
 * Copyright (C) 2008-2026 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2025-2026 LegionEmulationProject <https://github.com/LegionEmulationProject>
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

#ifndef __BROKEN_SHORE_SCENARIO_H__
#define __BROKEN_SHORE_SCENARIO_H__

#define DataHeader "BFBS"

uint32 const EncounterCount = 5;

enum CreatureIds
{
    // Alliance's NPCs
    NPC_GENN_GREYMANE   = 90717,       
    NPC_VARIAN          = 90713,             
    NPC_JAINA           = 90714,              
    NPC_TIRION          = 91951,

    // Horde's NPCs
    NPC_VOLJIN          = 90708,
    NPC_BAINE           = 90710,
    NPC_SYLVANAS        = 90709,

    // The Legion's NPCs
    NPC_JARAXXUS        = 105179,
    NPC_TICHONDRIUS     = 90688,
    NPC_BRUTALLUS       = 91902,   
    NPC_GULDAN          = 94276,

    // others
    NPC_KROSS           = 90544,
};

enum Spells
{
    SPELL_CANNONBALLS_SCENE_A = 183341,
    SPELL_CANNONBALLS_SCENE_H = 000000, // Spell Id Unknown

    SPELL_INTRO_CONVERSATION_1 = 180708, // Conversation Id: 923
    SPELL_INTRO_CONVERSATION_2 = 199353, // Conversation Id: 924
};

enum ScenarioDataAlliance
{
    SCENARIO_EVENT_INTRO,

    SCENARIO_ID_A                       = 786,

    STEP_TRAVEL_TO_BROKENSHORE          = 1504,
    STEP_BEACH_ASSAULT                  = 1522,
    STEP_SLAY_ARGANOTH                  = 2685,
    STEP_LOCATE_KING_WRYNN              = 1589,
    STEP_DESTROY_ALL_DEMON_PORTALS      = 1532,
    STEP_ASSAULT_DEMON_CITY             = 1505,
    STEP_GET_TIRION                     = 1506,
    STEP_KILL_KROSUS                    = 1761,
    STEP_STOP_GULDAN                    = 2084,
};

#endif // !__BROKEN_SHORE_SCENARIO_H__