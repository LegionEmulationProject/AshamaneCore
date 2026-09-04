/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 * This file is part of the LegionEmulation Project. See AUTHORS file for Copyright information
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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "Creature.h"
#include "Spell.h"
#include "Vehicle.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"

namespace CenariusKeeper
{
    enum QuestIds
    {
        QUEST_CENARIUS_KEEPER_OF_THE_GROVE = 40122,
    };

    enum CreatureIds
    {
        NPC_MALFURION_STORMRAGE   = 91462,
        NPC_MALFURION_VEHICLE     = 91465,
        NPC_MALFURION_TALKER      = 94588,
        NPC_NYANDRA               = 91652,
    };

    enum SpellIds
    {
        SPELL_SUMMON_MALFURION             = 181481,
        SPELL_RIDE_VEHICLE_HARDCODED       = 46598,
        SPELL_UPDATE_ZONE_AURAS            = 84034,
        SPELL_TRANSFORM_MALFURION_STAG     = 185846,
        SPELL_REVERSE_CAST_RIDE_SEAT_1     = 88885,
        SPELL_RIDE_VEHICLE                 = 52391,
        SPELL_REVERSE_CAST_SUMMON_NYANDRA  = 187438,
        SPELL_TRANSFORM_MALFURION          = 181483,
        SPELL_SUMMON_NYANDRA               = 181879,
        SPELL_CENARIUS_PLIGHT_CONVERSATION = 181485, // Play Conversation (352)
    };

    enum TextIds
    {
        SAY_AHH_VALSHARAH       = 0,
        SAY_EVERY_STEP          = 1,
        SAY_AGES_AGO            = 2,
        SAY_MERELY_AN_ECHO      = 3,
        SAY_MAKE_READY          = 4,
        SAY_FOLLOW_ME           = 5,
    };

    enum Events
    {
        EVENT_START_TRAVEL      = 1,
        EVENT_TALK_EVERY_STEP   = 2,
        EVENT_TALK_AGES_AGO     = 3,
        EVENT_TALK_MERELY_ECHO  = 4,
        EVENT_TALK_MAKE_READY   = 5,
        EVENT_EJECT_PLAYER      = 6,
        EVENT_NYANDRA_SEQUENCE  = 7,
        EVENT_NYANDRA_FOLLOW    = 8,
        EVENT_NYANDRA_STOP      = 9,
        EVENT_KNEEL              = 10,
    };
};


void AddSC_valsharah()
{

}
