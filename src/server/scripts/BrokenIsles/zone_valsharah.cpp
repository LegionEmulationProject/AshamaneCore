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
#include "Common.h"
#include "Spell.h"
#include "Vehicle.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"

#include "WorldSession.h"
#include "Chat.h"


enum QuestIds
{
    QUEST_CENARIUS_KEEPER_OF_THE_GROVE = 40122,
};
enum CreatureIds
{
    NPC_MALFURION_STORMRAGE             = 91462,
    NPC_MALFURION_SUMMON                = 91465,
    NPC_NYANDRA                         = 91652,
    NPC_KILLCREDIT_SPEAK_TO_MALFURION   = 91461,
};
enum SpellIds
{
    SPELL_SUMMON_MALFURION             = 181481,
    SPELL_RIDE_VEHICLE_HARDCODED       = 52391,
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
    EVENT_CAST_TRANFORM_SPELL,
    EVENT_PLAYER_CAST_SPELL,
    EVENT_START_TRAVEL,
    EVENT_TALK_AHH_VALSHARAH,
    EVENT_TALK_EVERY_STEP,
    EVENT_TALK_AGES_AGO,
    EVENT_TALK_MERELY_ECHO,
    EVENT_TALK_MAKE_READY,
    EVENT_FOLLOW_ME,
    EVENT_CENARIUS_PLIGHT_CONVERSATION,
    EVENT_KNEEL,
};
enum Etc
{
    PASSENGER_MALFURION = 1,
    WP_POSITION_END = 19,
    WP_POSITION_CENARIUS,
};
uint32 const malfurionpathSize = 18;
Position const malfurionPathToGrove[malfurionpathSize] =
{
    { 2291.473f, 6597.754f, 138.3059f },
    { 2297.973f, 6634.754f, 135.0559f },
    { 2324.473f, 6661.754f, 134.0559f },
    { 2333.473f, 6670.004f, 135.0559f },
    { 2355.223f, 6668.254f, 138.8059f },
    { 2370.723f, 6663.754f, 140.8059f },
    { 2383.473f, 6662.004f, 141.8059f },
    { 2397.973f, 6658.254f, 140.3059f },
    { 2412.973f, 6650.004f, 138.8059f },
    { 2424.723f, 6636.754f, 140.0559f },
    { 2450.723f, 6615.254f, 136.5559f },
    { 2470.223f, 6594.004f, 135.3059f },
    { 2498.473f, 6590.254f, 134.3059f },
    { 2534.473f, 6594.254f, 132.3059f },
    { 2572.223f, 6609.504f, 127.3059f },
    { 2601.973f, 6634.504f, 119.8059f },
    { 2614.723f, 6656.754f, 113.0559f },
    { 2614.723f, 6679.254f, 108.0559f },
};
uint32 const malfurionpathSize1 = 14;
Position const malfurionPathtoNyandra[malfurionpathSize1] =
{
    { 2610.267f, 6700.865f, 104.83893f },
    { 2610.017f, 6701.865f, 105.08893f },
    { 2609.767f, 6703.365f, 104.83893f },
    { 2610.017f, 6704.865f, 104.83893f },
    { 2610.017f, 6706.365f, 105.08893f },
    { 2610.017f, 6709.115f, 104.83893f },
    { 2609.767f, 6710.615f, 105.08893f },
    { 2610.017f, 6715.115f, 104.83893f },
    { 2610.017f, 6715.615f, 104.58893f },
    { 2610.017f, 6716.615f, 104.58893f },
    { 2609.267f, 6717.615f, 104.83893f },
    { 2608.767f, 6718.865f, 104.83893f },
    { 2608.517f, 6720.865f, 104.83893f },
    { 2606.8586f, 6724.6426f, 104.887665f },
};

class npc_malfurion_stormrage_91465 : public CreatureScript
{
public:
    npc_malfurion_stormrage_91465() : CreatureScript("npc_malfurion_stormrage_91465") { }

    struct npc_malfurion_stormrage_91465AI : public ScriptedAI
    {
        npc_malfurion_stormrage_91465AI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void Reset()
        {
            if (Player* player = me->SelectNearestPlayer(80.0f))
            {
                player->CastSpell(player, SPELL_REVERSE_CAST_RIDE_SEAT_1);
            }
            events.ScheduleEvent(EVENT_TALK_AHH_VALSHARAH, 1000);
            me->CastSpell(me, SPELL_TRANSFORM_MALFURION_STAG, false);
            events.ScheduleEvent(EVENT_PLAYER_CAST_SPELL, 2000);
        }

        void PassengerBoarded(Unit* passenger, int8 /*seatId*/, bool apply)
        {          
		    if (!apply)
		        return;

		    Player* player = passenger->ToPlayer();
		    if (!player)
		        return;
            
	        events.ScheduleEvent(EVENT_START_TRAVEL, 600);
	        events.ScheduleEvent(EVENT_TALK_EVERY_STEP, 7000);
            events.ScheduleEvent(EVENT_TALK_AGES_AGO, 16000);
            events.ScheduleEvent(EVENT_TALK_MERELY_ECHO, 28000);
            events.ScheduleEvent(EVENT_TALK_MAKE_READY, 40000);	        
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);
            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_TALK_AHH_VALSHARAH:
                        Talk(SAY_AHH_VALSHARAH);
                        break;
                    case EVENT_PLAYER_CAST_SPELL:
                        if (Player* player = me->SelectNearestPlayer(50.0f))
                            player->CastSpell(me, SPELL_RIDE_VEHICLE_HARDCODED);
                        break;
                    case EVENT_START_TRAVEL:
		                me->GetMotionMaster()->MoveSmoothPath(WP_POSITION_END, malfurionPathToGrove, malfurionpathSize, false, false);
                        break;
                    case EVENT_TALK_EVERY_STEP:
                        Talk(SAY_EVERY_STEP);			            
                        break;
                    case EVENT_TALK_AGES_AGO:
			            Talk(SAY_AGES_AGO);
                        break;
                    case EVENT_TALK_MERELY_ECHO:
                        Talk(SAY_MERELY_AN_ECHO);
                        break;
                    case EVENT_TALK_MAKE_READY:
                        Talk(SAY_MAKE_READY);
                        break;
                    case EVENT_FOLLOW_ME:
                            Talk(SAY_FOLLOW_ME);
			                // me->GetMotionMaster()->MoveSmoothPath(WP_POSITION_END, malfurionPathtoNyandra, malfurionpathSize1, true, false);
                        	break;
		            case EVENT_CENARIUS_PLIGHT_CONVERSATION:
			            if (Player* player = me->SelectNearestPlayer(50.0f))
			            {
                            if (player->HasQuest(QUEST_CENARIUS_KEEPER_OF_THE_GROVE))
			                    player->CastSpell(player, SPELL_CENARIUS_PLIGHT_CONVERSATION, true);
			            }
			            break;
                    case EVENT_KNEEL:
                        me->GetMotionMaster()->Clear();
                        me->SetFacingTo(1.7976891);
                        me->SetStandState(UNIT_STAND_STATE_KNEEL);
                        break;
                    default:
                        break;
                }
            }
        }

        void MovementInform(uint32 type, uint32 point) override
        {
            switch (point)
            {
                case WP_POSITION_END:
                    if (Player* player = me->SelectNearestPlayer(50.0f))
                    {
                        if (player->GetVehicleBase() == me)
                            player->ExitVehicle();
			                me->CastSpell(me, SPELL_TRANSFORM_MALFURION, true);
			                me->CastSpell(player, SPELL_REVERSE_CAST_SUMMON_NYANDRA, true);
                        events.ScheduleEvent(EVENT_FOLLOW_ME, 1000);
                    }
                    break;
                case WP_POSITION_CENARIUS:
                    events.ScheduleEvent(EVENT_KNEEL, 1000);
                    break;
                default:
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_malfurion_stormrage_91465AI(creature);
    }
};


void AddSC_valsharah()
{
    new npc_malfurion_stormrage_91465();
}
