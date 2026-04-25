/*
 * Copyright (C) 2017-2018 AshamaneProject <https://github.com/AshamaneProject>
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
#include "GameObject.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "PhasingHandler.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SpellAuraEffects.h"
#include "SpellHistory.h"
#include "SpellMgr.h"
#include "SpellPackets.h"
#include "SpellScript.h"

/*
 * Dalaran above Karazhan
 *
 * Legion Intro
 */

enum
{
    PHASE_DALARAN_KARAZHAN  = 5829,
    QUEST_BLINK_OF_AN_EYE   = 44663,
};

// TODO : All this script is temp fix,
// remove it when legion start quests are properly fixed
class OnLegionArrival : public PlayerScript
{
public:
    OnLegionArrival() : PlayerScript("OnLegionArrival") { }

    enum
    {
        SPELL_MAGE_LEARN_GUARDIAN_HALL_TP   = 204287,
        SPELL_WAR_LEARN_JUMP_TO_SKYHOLD     = 192084,
        SPELL_DRUID_CLASS_HALL_TP           = 204874,
        SPELL_CREATE_CLASS_HALL_ALLIANCE    = 185506,
        SPELL_CREATE_CLASS_HALL_HORDE       = 192191,

        CONVERSATION_KHADGAR_BLINK_OF_EYE   = 3827,
    };

    void OnLogin(Player* player, bool firstLogin) override
    {
        // Can happen in recovery cases
        if (player->getLevel() >= 100 && firstLogin)
            HandleLegionArrival(player);
    }

    void OnLevelChanged(Player* player, uint8 oldLevel) override
    {
        if (oldLevel < 100 && player->getLevel() >= 100)
            HandleLegionArrival(player);
    }

    void HandleLegionArrival(Player* player)
    {
        switch (player->getClass())
        {
            case CLASS_MAGE:
                player->CastSpell(player, SPELL_MAGE_LEARN_GUARDIAN_HALL_TP, true);
                break;
            case CLASS_WARRIOR:
                player->CastSpell(player, SPELL_WAR_LEARN_JUMP_TO_SKYHOLD, true);
                break;
            case CLASS_DRUID:
                player->CastSpell(player, SPELL_DRUID_CLASS_HALL_TP, true);
                break;
            case CLASS_HUNTER:
                player->m_taxi.SetTaximaskNode(1848); // Hunter Class Hall
                break;
            default:
                break;
        }

        player->CastSpell(player, player->IsInAlliance() ? SPELL_CREATE_CLASS_HALL_ALLIANCE : SPELL_CREATE_CLASS_HALL_HORDE, true);

        if (player->GetQuestStatus(QUEST_BLINK_OF_AN_EYE) == QUEST_STATUS_NONE)
        {
            if (const Quest* quest = sObjectMgr->GetQuestTemplate(QUEST_BLINK_OF_AN_EYE))
                player->AddQuest(quest, nullptr);
        }
    }
};

class On110Arrival : public PlayerScript
{
public:
    On110Arrival() : PlayerScript("On110Arrival") { }

    enum
    {
        QUEST_UNITING_THE_ISLES     = 43341,
    };

    void OnLogin(Player* player, bool firstLogin) override
    {
        // Can happen in recovery cases
        if (player->getLevel() >= 110 && firstLogin)
            Handle110Arrival(player);
    }

    void OnLevelChanged(Player* player, uint8 oldLevel) override
    {
        if (oldLevel < 110 && player->getLevel() >= 110)
            Handle110Arrival(player);
    }

    void Handle110Arrival(Player* player)
    {
        if (player->GetQuestStatus(QUEST_UNITING_THE_ISLES) == QUEST_STATUS_NONE)
            if (const Quest* quest = sObjectMgr->GetQuestTemplate(QUEST_UNITING_THE_ISLES))
                player->AddQuest(quest, nullptr);
    }
};

// 228329 & 228330 - T�l�portation
class spell_dalaran_teleportation : public SpellScript
{
    PrepareSpellScript(spell_dalaran_teleportation);

    void EffectTeleportDalaranKarazhan(SpellEffIndex effIndex)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            if (player->getLevel() < 100 || player->GetQuestStatus(QUEST_BLINK_OF_AN_EYE) != QUEST_STATUS_INCOMPLETE)
                PreventHitEffect(effIndex);
            else
            {
                if (SpellTargetPosition const* targetPosition = sSpellMgr->GetSpellTargetPosition(GetSpellInfo()->Id, effIndex))
                    if (Map* map = sMapMgr->FindMap(targetPosition->target_mapId, 0))
                        map->LoadGrid(targetPosition->target_X, targetPosition->target_Y);
            }
        }
    }

    void EffectTeleportDalaranLegion(SpellEffIndex effIndex)
    {
        if (Player* player = GetCaster()->ToPlayer())
            if (player->getLevel() < 100 || player->GetQuestStatus(QUEST_BLINK_OF_AN_EYE) == QUEST_STATUS_INCOMPLETE)
                PreventHitEffect(effIndex);
    }

    void Register() override
    {
        OnEffectLaunch += SpellEffectFn(spell_dalaran_teleportation::EffectTeleportDalaranKarazhan, EFFECT_0, SPELL_EFFECT_TRIGGER_SPELL);
        OnEffectLaunch += SpellEffectFn(spell_dalaran_teleportation::EffectTeleportDalaranLegion, EFFECT_1, SPELL_EFFECT_TRIGGER_SPELL);
    }
};

// 113986 - Khadgar
class npc_dalaran_karazhan_khadgar : public CreatureScript
{
public:
    npc_dalaran_karazhan_khadgar() : CreatureScript("npc_dalaran_karazhan_khadgar") { }

    enum
    {
        SPELL_PLAY_DALARAN_TELEPORTATION_SCENE = 227861
    };

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*uiSender*/, uint32 /*uiAction*/) override
    {
        player->CastSpell(player, SPELL_PLAY_DALARAN_TELEPORTATION_SCENE, true);
        return true;
    }
};

class scene_dalaran_kharazan_teleportion : public SceneScript
{
public:
    scene_dalaran_kharazan_teleportion() : SceneScript("scene_dalaran_kharazan_teleportion") { }

    void OnSceneTriggerEvent(Player* player, uint32 /*sceneInstanceID*/, SceneTemplate const* /*sceneTemplate*/, std::string const& triggerName) override
    {
        if (triggerName == "invisibledalaran")
            PhasingHandler::AddPhase(player, PHASE_DALARAN_KARAZHAN);
    }

    void OnSceneEnd(Player* player, uint32 /*sceneInstanceID*/, SceneTemplate const* /*sceneTemplate*/) override
    {
        player->KilledMonsterCredit(114506);
        player->TeleportTo(1220, -827.82f, 4369.25f, 738.64f, 1.893364f);
    }
};

/*
 * Legion Dalaran
 */

// Zone 8392
class zone_legion_dalaran_underbelly : public ZoneScript
{
public:
    zone_legion_dalaran_underbelly() : ZoneScript("zone_legion_dalaran_underbelly") { }

    void OnPlayerEnter(Player* player) override
    {
        player->SeamlessTeleportToMap(MAP_DALARAN_UNDERBELLY);
    }

    void OnPlayerExit(Player* player) override
    {
        if (player->GetMapId() == MAP_DALARAN_UNDERBELLY)
            player->SeamlessTeleportToMap(MAP_BROKEN_ISLANDS);
    }
};

enum OrderCampaignDalaranIntro
{
    // Quest
    QUEST_AN_IMPORTANT_MISSION              = 42814,
    QUEST_A_DESPERATE_PLEA                  = 41052,
    QUEST_FELSTORMS_PLEA                    = 41035,
    QUEST_NEEDS_OF_THE_HUNTER               = 40384,
    QUEST_CALL_OF_THE_UNCROWNED             = 40832,
    QUEST_PRIESTLY_MATTERS                  = 40705,
    QUEST_THE_SIXTH                         = 40716,
    QUEST_AN_URGENT_GATHERING               = 38710,
    QUEST_A_SUMMONS_FROM_MOONGLADE          = 40643,
    QUEST_BEFORE_THE_STORM                  = 12103,
    QUEST_CALL_OF_THE_ILLIDARI_ALTRUIS      = 39047,
    QUEST_CALL_OF_THE_ILLIDARI_JAYCE        = 39261,
    QUEST_THE_CALL_TO_WAR                   = 40714,

    // Tracking Quests DH
    QUEST_A_NEW_DIRECTION_ALTRUIS           = 40375,
    QUEST_A_NEW_DIRECTION_JAYCE             = 40374,

    // Mage
    SPELL_MAGE_ORDER_FORMATION              = 195356,

    // Death Knight
    SPELL_AN_AUDIENCE_WITH_THE_KING         = 200023,

    // Summon Spells
    SPELL_SUMMON_DALTON_WARRIOR             = 216497,
    SPELL_SUMMON_EITRIGG_WARRIOR            = 216443,
    SPELL_SUMMON_SNOWFEATHER_HUNTER         = 196908,
    SPELL_SUMMON_RAVENHOLDT_COURIER_ROGUE   = 201208,
    SPELL_A_SUMMON_MESSENGER_PRIEST         = 202051,
    SPELL_H_SUMMON_MESSENGER_PRIEST         = 226409,
    SPELL_SUMMON_RYSSTINS_PORTAL_WARLOCK    = 204858,
    SPELL_SUMMON_RYSSTINS_WARLOCK           = 204860,
    SPELL_SUMMON_MAXWELL_TYROSUS_PALADIN    = 190886,
    SPELL_SUMMON_DA_NEL_MONK                = 193978,
    SPELL_SUMMON_KORVAS_DH                  = 195286,
	SPELL_SUMMON_ALTRUIS_DH                 = 188458,
    SPELL_SUMMON_RUNETOTEM_DRUID            = 199277
};

// 224240 - 7.0 Order Campaign - Dalaran Aura
class spell_dalaran_order_campaign_intro_aura : public SpellScriptLoader
{
public:
    spell_dalaran_order_campaign_intro_aura() : SpellScriptLoader("spell_dalaran_order_campaign_intro_aura") { }

    class spell_dalaran_order_campaign_intro_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_dalaran_order_campaign_intro_AuraScript);

        void HandlePeriodic(AuraEffect const* /*aurEff*/)
        {
            Player* player = GetCaster() ? GetCaster()->ToPlayer() : nullptr;
            if (!player)
                return;

            switch (player->getClass())
            {
                case CLASS_WARRIOR:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE && player->GetQuestStatus(QUEST_AN_IMPORTANT_MISSION) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_DALTON_WARRIOR, true);
                    else if (player->GetTeamId() == TEAM_HORDE && player->GetQuestStatus(QUEST_A_DESPERATE_PLEA) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_EITRIGG_WARRIOR, true);
                    break;
                }
                case CLASS_HUNTER:
                {
                    if (player->GetQuestStatus(QUEST_NEEDS_OF_THE_HUNTER) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_SNOWFEATHER_HUNTER, true);
                    break;
                }
                case CLASS_MAGE:
                {
                    if (player->GetQuestStatus(QUEST_FELSTORMS_PLEA) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_MAGE_ORDER_FORMATION, true);
                    break;
                }
                case CLASS_ROGUE:
                {
                    if (player->GetQuestStatus(QUEST_CALL_OF_THE_UNCROWNED) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_RAVENHOLDT_COURIER_ROGUE, true);
                    break;
                }
                case CLASS_PRIEST:
                {
                    if (player->GetTeamId() == TEAM_ALLIANCE && player->GetQuestStatus(QUEST_PRIESTLY_MATTERS) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_A_SUMMON_MESSENGER_PRIEST, true);
                    else if (player->GetTeamId() == TEAM_HORDE && player->GetQuestStatus(QUEST_PRIESTLY_MATTERS) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_H_SUMMON_MESSENGER_PRIEST, true);
                    break;
                }
                case CLASS_WARLOCK:
                {
                    if (player->GetQuestStatus(QUEST_THE_SIXTH) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_RYSSTINS_PORTAL_WARLOCK, true);
                    break;
                }
                case CLASS_PALADIN:
                {
                    if (player->GetQuestStatus(QUEST_AN_URGENT_GATHERING) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_MAXWELL_TYROSUS_PALADIN, true);
                    break;
                }
                case CLASS_DRUID:
                {
                    if (player->GetQuestStatus(QUEST_A_SUMMONS_FROM_MOONGLADE) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_RUNETOTEM_DRUID, true);
                    break;
                }
                case CLASS_MONK:
                {
                    if (player->GetQuestStatus(QUEST_BEFORE_THE_STORM) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_SUMMON_DA_NEL_MONK, true);
                    break;
                }
                case CLASS_DEMON_HUNTER:
                {
                    if (player->GetQuestStatus(QUEST_CALL_OF_THE_ILLIDARI_ALTRUIS) == QUEST_STATUS_NONE && player->GetQuestStatus(QUEST_A_NEW_DIRECTION_ALTRUIS) == QUEST_STATUS_REWARDED)
                        player->CastSpell(nullptr, SPELL_SUMMON_KORVAS_DH, true);
                    else if (player->GetQuestStatus(QUEST_CALL_OF_THE_ILLIDARI_JAYCE) == QUEST_STATUS_NONE && player->GetQuestStatus(QUEST_A_NEW_DIRECTION_JAYCE) == QUEST_STATUS_REWARDED)
                        player->CastSpell(nullptr, SPELL_SUMMON_KORVAS_DH, true);
                    break;
                }
                case CLASS_DEATH_KNIGHT:
                {
                    if (player->GetQuestStatus(QUEST_THE_CALL_TO_WAR) == QUEST_STATUS_NONE)
                        player->CastSpell(nullptr, SPELL_AN_AUDIENCE_WITH_THE_KING, true);
                    break;
                }
                default:
                    break;
            }
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_dalaran_order_campaign_intro_AuraScript::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_dalaran_order_campaign_intro_AuraScript();
    }
};

enum DownToAzsuna
{
    QUEST_PARADISE_LOST                = 39718,
    QUEST_DOWN_TO_AZSUNA               = 41220,
    SAY_KHADGAR_FIRST_LINE             = 0,
    SAY_KHADGAR_SECOND_LINE            = 1,

    SPELL_TAXI_DALARAN_AZSUNA_ALLIANCE = 205098,
    SPELL_TAXI_DALARAN_AZSUNA_HORDE    = 205203,

    SPELL_DOWN_TO_AZSUNA_SUMMON_KHADGAR_RAVEN = 205204,
};

class npc_archmage_khadgar_86563 : public CreatureScript
{
public:
    npc_archmage_khadgar_86563() : CreatureScript("npc_archmage_khadgar_86563") { }

    struct npc_archmage_khadgar_86563AI : public ScriptedAI
    {
        npc_archmage_khadgar_86563AI(Creature* creature) : ScriptedAI(creature) { }

        bool KhadgarSayLine = false;

        void MoveInLineOfSight(Unit* who) override
        {
            ScriptedAI::MoveInLineOfSight(who);

            if (!who)
                return;

            if (Player* player = who->ToPlayer())
            {
                if (player->GetQuestStatus(QUEST_PARADISE_LOST) == QUEST_STATUS_COMPLETE)
                {
                    if (me->IsWithinDistInMap(player, 35.0f))
                    {
                        if (KhadgarSayLine)
                            return;

                        Talk(SAY_KHADGAR_FIRST_LINE, player);
                        KhadgarSayLine = true;
                    }
                }
            }
        }
    };

    bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 /*action*/) override
    {
        if (player->HasQuest(QUEST_DOWN_TO_AZSUNA) || player->GetQuestStatus(QUEST_DOWN_TO_AZSUNA) == QUEST_STATUS_INCOMPLETE)
            player->CastSpell(player, player->IsInAlliance() ? SPELL_TAXI_DALARAN_AZSUNA_ALLIANCE : SPELL_TAXI_DALARAN_AZSUNA_HORDE, true);

        return true;
    }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_DOWN_TO_AZSUNA)
        {
            creature->AI()->Talk(SAY_KHADGAR_SECOND_LINE, player);
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_archmage_khadgar_86563AI(creature);
    }
};

class quest_down_to_azsuna : public QuestScript
{
public:
    quest_down_to_azsuna() : QuestScript("quest_down_to_azsuna") { }

    void OnQuestStatusChange(Player* player, Quest const* /*quest*/, QuestStatus /*oldStatus*/, QuestStatus newStatus) override
    {
        if (newStatus = QUEST_STATUS_COMPLETE)
        {
            player->CastSpell(player, SPELL_DOWN_TO_AZSUNA_SUMMON_KHADGAR_RAVEN, true);
        }
    }
};

enum KhadgarRaven
{
    EVENT_SAY_FIRST_LINE,
    EVENT_SAY_SECOND_LINE,
    EVENT_SAY_THIRD_LINE,
    EVENT_SAY_FOURTH_LINE,
    EVENT_SAY_FIFTH_LINE,
    EVENT_SAY_SIXTH_LINE,
    EVENT_DESPAWN,

    SAY_KHADGAR_RAVEN_FIRST_LINE  = 0,
    SAY_KHADGAR_RAVEN_SECOND_LINE = 1,
    SAY_KHADGAR_RAVEN_THIRD_LINE  = 2,
    SAY_KHADGAR_RAVEN_FOURTH_LINE = 3,
    SAY_KHADGAR_RAVEN_FIFTH_LINE  = 4,
    SAY_KHADGAR_RAVEN_SIXTH_LINE  = 5,
};

class npc_archmage_khadgar_103660: public CreatureScript
{
public:
    npc_archmage_khadgar_103660() : CreatureScript("npc_archmage_khadgar_103660") { }

    struct npc_archmage_khadgar_103660AI : public ScriptedAI
    {
        npc_archmage_khadgar_103660AI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void Reset() override
        {
            events.Reset();
            events.ScheduleEvent(EVENT_SAY_FIRST_LINE, 9484);
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_SAY_FIRST_LINE:
                        Talk(SAY_KHADGAR_RAVEN_FIRST_LINE);
                        events.ScheduleEvent(EVENT_SAY_SECOND_LINE, 11313); 
                        break;

                    case EVENT_SAY_SECOND_LINE:
                        Talk(SAY_KHADGAR_RAVEN_SECOND_LINE);
                        events.ScheduleEvent(EVENT_SAY_THIRD_LINE, 49538); 
                        break;

                    case EVENT_SAY_THIRD_LINE:
                        Talk(SAY_KHADGAR_RAVEN_THIRD_LINE);
                        events.ScheduleEvent(EVENT_SAY_FOURTH_LINE, 11203);
                        break;

                    case EVENT_SAY_FOURTH_LINE:
                        Talk(SAY_KHADGAR_RAVEN_FOURTH_LINE);
                        events.ScheduleEvent(EVENT_SAY_FIFTH_LINE, 12516);
                        break;

                    case EVENT_SAY_FIFTH_LINE:
                        Talk(SAY_KHADGAR_RAVEN_FIFTH_LINE);
                        events.ScheduleEvent(EVENT_SAY_SIXTH_LINE, 13406);
                        break;

                    case EVENT_SAY_SIXTH_LINE:
                        Talk(SAY_KHADGAR_RAVEN_SIXTH_LINE);
                        events.ScheduleEvent(EVENT_DESPAWN, 5156);
                        break;

                    case EVENT_DESPAWN:
                        me->DespawnOrUnsummon();
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_archmage_khadgar_103660AI(creature);
    }
};


void AddSC_zone_dalaran_broken_isle()
{
    // new OnLegionArrival();
    new On110Arrival();

    RegisterSpellScript(spell_dalaran_teleportation);
    new npc_dalaran_karazhan_khadgar();
    new scene_dalaran_kharazan_teleportion();
    new zone_legion_dalaran_underbelly();
	new npc_archmage_khadgar_86563();
    new quest_down_to_azsuna();
    new npc_archmage_khadgar_103660();

    // Spellscripts
    new spell_dalaran_order_campaign_intro_aura();
}
