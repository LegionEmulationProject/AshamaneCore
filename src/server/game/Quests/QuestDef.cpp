/*
 * Copyright (C) 2008-2018 TrinityCore <https://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

#include "QuestDef.h"
#include "DB2Stores.h"
#include "Field.h"
#include "GameTables.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestPackets.h"
#include "World.h"

Quest::Quest(Field* questRecord)
{
    _emoteOnIncomplete = 0;
    _emoteOnComplete = 0;
    _rewItemsCount = 0;
    _rewChoiceItemsCount = 0;
    _rewCurrencyCount = 0;

    _id = questRecord[0].GetUInt32();
    _type = questRecord[1].GetUInt8();
    _level = questRecord[2].GetInt32();
    _maxScalingLevel = questRecord[3].GetInt32();
    _packageID = questRecord[4].GetUInt32();
    _minLevel = questRecord[5].GetInt32();
    _questSortID = questRecord[6].GetInt16();
    _questInfoID = questRecord[7].GetUInt16();
    _suggestedPlayers = questRecord[8].GetUInt8();
    _nextQuestInChain = questRecord[9].GetUInt32();
    _rewardXPDifficulty = questRecord[10].GetUInt32();
    _rewardXPMultiplier = questRecord[11].GetFloat();
    _rewardMoney = questRecord[12].GetUInt32();
    _rewardMoneyDifficulty = questRecord[13].GetUInt32();
    _rewardMoneyMultiplier = questRecord[14].GetFloat();
    _rewardBonusMoney = questRecord[15].GetUInt32();
    for (uint32 i = 0; i < QUEST_REWARD_DISPLAY_SPELL_COUNT; ++i)
        RewardDisplaySpell[i] = questRecord[16 + i].GetUInt32();

    _rewardSpell = questRecord[19].GetUInt32();
    _rewardHonor = questRecord[20].GetUInt32();
    _rewardKillHonor = questRecord[21].GetUInt32();
    _sourceItemId = questRecord[22].GetUInt32();
    _rewardArtifactXPDifficulty = questRecord[23].GetUInt32();
    _rewardArtifactXPMultiplier = questRecord[24].GetFloat();
    _rewardArtifactCategoryID = questRecord[25].GetUInt32();
    _flags = questRecord[26].GetUInt32();
    _flagsEx = questRecord[27].GetUInt32();

    for (uint32 i = 0; i < QUEST_ITEM_DROP_COUNT; ++i)
    {
        RewardItemId[i] = questRecord[28 + i * 4].GetUInt32();
        RewardItemCount[i] = questRecord[29 + i * 4].GetUInt32();
        ItemDrop[i] = questRecord[30 + i * 4].GetUInt32();
        ItemDropQuantity[i] = questRecord[31 + i * 4].GetUInt32();

        if (RewardItemId[i])
            ++_rewItemsCount;
    }

    for (uint32 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
    {
        RewardChoiceItemId[i] = questRecord[44 + i * 3].GetUInt32();
        RewardChoiceItemCount[i] = questRecord[45 + i * 3].GetUInt32();
        RewardChoiceItemDisplayId[i] = questRecord[46 + i * 3].GetUInt32();

        if (RewardChoiceItemId[i])
            ++_rewChoiceItemsCount;
    }

    _poiContinent = questRecord[62].GetUInt32();
    _poix = questRecord[63].GetFloat();
    _poiy = questRecord[64].GetFloat();
    _poiPriority = questRecord[65].GetUInt32();

    _rewardTitleId = questRecord[66].GetUInt32();
    _rewardArenaPoints = questRecord[67].GetUInt32();
    _rewardSkillId = questRecord[68].GetUInt32();
    _rewardSkillPoints = questRecord[69].GetUInt32();

    _questGiverPortrait = questRecord[70].GetUInt32();
    _questTurnInPortrait = questRecord[71].GetUInt32();

    for (uint32 i = 0; i < QUEST_REWARD_REPUTATIONS_COUNT; ++i)
    {
        RewardFactionId[i] = questRecord[72 + i * 4].GetUInt32();
        RewardFactionValue[i] = questRecord[73 + i * 4].GetInt32();
        RewardFactionOverride[i] = questRecord[74 + i * 4].GetInt32();
        RewardFactionCapIn[i] = questRecord[75 + i * 4].GetUInt32();
    }

    _rewardReputationMask = questRecord[92].GetUInt32();

    for (uint32 i = 0; i < QUEST_REWARD_CURRENCY_COUNT; ++i)
    {
        RewardCurrencyId[i] = questRecord[93 + i * 2].GetUInt32();
        RewardCurrencyCount[i] = questRecord[94 + i * 2].GetUInt32();

        if (RewardCurrencyId[i])
            ++_rewCurrencyCount;
    }

    _soundAccept = questRecord[101].GetUInt32();
    _soundTurnIn = questRecord[102].GetUInt32();
    _areaGroupID = questRecord[103].GetUInt32();
    _limitTime = questRecord[104].GetUInt32();
    _allowableRaces = questRecord[105].GetUInt64();
    _questRewardID = questRecord[106].GetUInt32();
    _expansion = questRecord[107].GetInt32();

    _logTitle = questRecord[108].GetString();
    _logDescription = questRecord[109].GetString();
    _questDescription = questRecord[110].GetString();
    _areaDescription = questRecord[111].GetString();
    _portraitGiverText = questRecord[112].GetString();
    _portraitGiverName = questRecord[113].GetString();
    _portraitTurnInText = questRecord[114].GetString();
    _portraitTurnInName = questRecord[115].GetString();
    _questCompletionLog = questRecord[116].GetString();

    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
    {
        DetailsEmote[i] = 0;
        DetailsEmoteDelay[i] = 0;
        OfferRewardEmote[i] = 0;
        OfferRewardEmoteDelay[i] = 0;
    }
}

void Quest::LoadQuestDetails(Field* fields)
{
    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
    {
        if (!sEmotesStore.LookupEntry(fields[1 + i].GetUInt16()))
        {
            TC_LOG_ERROR("sql.sql", "Table `quest_details` has non-existing Emote%i (%u) set for quest %u. Skipped.", 1+i, fields[1+i].GetUInt16(), fields[0].GetUInt32());
            continue;
        }

        DetailsEmote[i] = fields[1 + i].GetUInt16();
    }

    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
        DetailsEmoteDelay[i] = fields[5 + i].GetUInt32();
}

void Quest::LoadQuestRequestItems(Field* fields)
{
    _emoteOnComplete = fields[1].GetUInt16();
    _emoteOnIncomplete = fields[2].GetUInt16();

    if (!sEmotesStore.LookupEntry(_emoteOnComplete))
        TC_LOG_ERROR("sql.sql", "Table `quest_request_items` has non-existing EmoteOnComplete (%u) set for quest %u.", _emoteOnComplete, fields[0].GetUInt32());

    if (!sEmotesStore.LookupEntry(_emoteOnIncomplete))
        TC_LOG_ERROR("sql.sql", "Table `quest_request_items` has non-existing EmoteOnIncomplete (%u) set for quest %u.", _emoteOnIncomplete, fields[0].GetUInt32());

    _emoteOnCompleteDelay = fields[3].GetUInt32();
    _emoteOnIncompleteDelay = fields[4].GetUInt32();
    _requestItemsText = fields[5].GetString();
}

void Quest::LoadQuestOfferReward(Field* fields)
{
    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
    {
        if (!sEmotesStore.LookupEntry(fields[1 + i].GetUInt16()))
        {
            TC_LOG_ERROR("sql.sql", "Table `quest_offer_reward` has non-existing Emote%i (%u) set for quest %u. Skipped.", 1+i, fields[1+i].GetUInt16(), fields[0].GetUInt32());
            continue;
        }

        OfferRewardEmote[i] = fields[1 + i].GetUInt16();
    }

    for (uint32 i = 0; i < QUEST_EMOTE_COUNT; ++i)
        OfferRewardEmoteDelay[i] = fields[5 + i].GetUInt32();

    _offerRewardText = fields[9].GetString();
}

void Quest::LoadQuestTemplateAddon(Field* fields)
{
    _maxLevel = fields[1].GetUInt8();
    _allowableClasses = fields[2].GetUInt32();
    _sourceSpellID = fields[3].GetUInt32();
    _prevQuestID = fields[4].GetInt32();
    _nextQuestID = fields[5].GetUInt32();
    _exclusiveGroup = fields[6].GetInt32();
    _rewardMailTemplateId = fields[7].GetUInt32();
    _rewardMailDelay = fields[8].GetUInt32();
    _requiredSkillId = fields[9].GetUInt16();
    _requiredSkillPoints = fields[10].GetUInt16();
    _requiredMinRepFaction = fields[11].GetUInt16();
    _requiredMaxRepFaction = fields[12].GetUInt16();
    _requiredMinRepValue = fields[13].GetInt32();
    _requiredMaxRepValue = fields[14].GetInt32();
    _sourceItemIdCount = fields[15].GetUInt8();
    _specialFlags = fields[16].GetUInt8();
    _scriptId = sObjectMgr->GetScriptId(fields[17].GetString());

    if (_specialFlags & QUEST_SPECIAL_FLAGS_AUTO_ACCEPT)
        _flags |= QUEST_FLAGS_AUTO_ACCEPT;
}

void Quest::LoadQuestMailSender(Field* fields)
{
    _rewardMailSenderEntry = fields[1].GetUInt32();
}

void Quest::LoadQuestObjective(Field* fields)
{
    QuestObjective obj;
    obj.QuestID = fields[0].GetUInt32();
    obj.ID = fields[1].GetUInt32();
    obj.Type = fields[2].GetUInt8();
    obj.StorageIndex = fields[3].GetInt8();
    obj.ObjectID = fields[4].GetInt32();
    obj.Amount = fields[5].GetInt32();
    obj.Flags = fields[6].GetUInt32();
    obj.Flags2 = fields[7].GetUInt32();
    obj.ProgressBarWeight = fields[8].GetFloat();
    obj.Description = fields[9].GetString();

    Objectives.push_back(obj);
}

void Quest::LoadQuestObjectiveVisualEffect(Field* fields)
{
    uint32 objID = fields[1].GetUInt32();

    for (QuestObjective& obj : Objectives)
    {
        if (obj.ID == objID)
        {
            uint8 effectIndex = fields[3].GetUInt8();
            if (effectIndex >= obj.VisualEffects.size())
                obj.VisualEffects.resize(effectIndex + 1, 0);

            obj.VisualEffects[effectIndex] = fields[4].GetInt32();
            break;
        }
    }
}

uint32 Quest::XPValue(uint32 playerLevel) const
{
    if (playerLevel)
    {
        uint32 questLevel = uint32(_level == -1 ? std::min(playerLevel, uint32(GetQuestMaxScalingLevel())) : _level);
        QuestXPEntry const* questXp = sQuestXPStore.LookupEntry(questLevel);
        if (!questXp || _rewardXPDifficulty >= 10)
            return 0;

        float multiplier = 1.0f;
        if (questLevel != playerLevel)
            multiplier = sXpGameTable.GetRow(std::min(playerLevel, questLevel))->Divisor / sXpGameTable.GetRow(playerLevel)->Divisor;

        int32 diffFactor = 2 * (questLevel - playerLevel) + 20;
        if (diffFactor < 1)
            diffFactor = 1;
        else if (diffFactor > 10)
            diffFactor = 10;

        uint32 xp = diffFactor * questXp->Difficulty[_rewardXPDifficulty] * _rewardXPMultiplier / 10 * multiplier;
        if (xp <= 100)
            xp = 5 * ((xp + 2) / 5);
        else if (xp <= 500)
            xp = 10 * ((xp + 5) / 10);
        else if (xp <= 1000)
            xp = 25 * ((xp + 12) / 25);
        else
            xp = 50 * ((xp + 25) / 50);

        return xp;
    }

    return 0;
}

uint32 Quest::MoneyValue(uint8 playerLevel) const
{
    uint8 level = _level == -1 ? playerLevel : _level;

    if (QuestMoneyRewardEntry const* money = sQuestMoneyRewardStore.LookupEntry(level))
        return money->Difficulty[GetRewMoneyDifficulty()] * GetMoneyMultiplier();
    else
        return 0;
}

void Quest::BuildQuestRewards(WorldPackets::Quest::QuestRewards& rewards, Player* player) const
{
    rewards.ChoiceItemCount         = GetRewChoiceItemsCount();
    rewards.ItemCount               = GetRewItemsCount();
    rewards.Money                   = player->GetQuestMoneyReward(this);
    rewards.XP                      = player->GetQuestXPReward(this);
    rewards.ArtifactCategoryID      = GetArtifactCategoryId();
    rewards.Title                   = GetRewTitle();
    rewards.FactionFlags            = GetRewardReputationMask();
    for (uint32 i = 0; i < QUEST_REWARD_DISPLAY_SPELL_COUNT; ++i)
        rewards.SpellCompletionDisplayID[i] = RewardDisplaySpell[i];

    rewards.SpellCompletionID       = GetRewSpell();
    rewards.SkillLineID             = GetRewardSkillId();
    rewards.NumSkillUps             = GetRewardSkillPoints();
    rewards.RewardID                = GetRewardId();

    for (uint32 i = 0; i < QUEST_REWARD_CHOICES_COUNT; ++i)
    {
        rewards.ChoiceItems[i].ItemID = RewardChoiceItemId[i];
        rewards.ChoiceItems[i].Quantity = RewardChoiceItemCount[i];
    }

    for (uint32 i = 0; i < QUEST_REWARD_ITEM_COUNT; ++i)
    {
        rewards.ItemID[i] = RewardItemId[i];
        rewards.ItemQty[i] = RewardItemCount[i];
    }

    for (uint32 i = 0; i < QUEST_REWARD_REPUTATIONS_COUNT; ++i)
    {
        rewards.FactionID[i] = RewardFactionId[i];
        rewards.FactionValue[i] = RewardFactionValue[i];
        rewards.FactionOverride[i] = RewardFactionOverride[i];
        rewards.FactionCapIn[i] = RewardFactionCapIn[i];
    }

    for (uint32 i = 0; i < QUEST_REWARD_CURRENCY_COUNT; ++i)
    {
        rewards.CurrencyID[i] = RewardCurrencyId[i];
        rewards.CurrencyQty[i] = RewardCurrencyCount[i];
    }
}

uint32 Quest::GetRewMoneyMaxLevel() const
{
    // If Quest has flag to not give money on max level, it's 0
    if (HasFlag(QUEST_FLAGS_NO_MONEY_FROM_XP))
        return 0;

    // Else, return the rewarded copper sum modified by the rate
    return uint32(_rewardBonusMoney * sWorld->getRate(RATE_MONEY_MAX_LEVEL_QUEST));
}

bool Quest::IsAutoAccept() const
{
    return !sWorld->getBoolConfig(CONFIG_QUEST_IGNORE_AUTO_ACCEPT) && HasFlag(QUEST_FLAGS_AUTO_ACCEPT);
}

bool Quest::IsAutoComplete() const
{
    return !sWorld->getBoolConfig(CONFIG_QUEST_IGNORE_AUTO_COMPLETE) && _type == QUEST_TYPE_AUTOCOMPLETE;
}

bool Quest::IsRaidQuest(Difficulty difficulty) const
{
    switch (_questInfoID)
    {
        case QUEST_INFO_RAID:
            return true;
        case QUEST_INFO_RAID_10:
            return difficulty == DIFFICULTY_10_N || difficulty == DIFFICULTY_10_HC;
        case QUEST_INFO_RAID_25:
            return difficulty == DIFFICULTY_25_N || difficulty == DIFFICULTY_25_HC;
        default:
            break;
    }

    if ((_flags & QUEST_FLAGS_RAID) != 0)
        return true;

    return false;
}

bool Quest::IsWorldQuest() const
{
    switch (_questInfoID)
    {
        case QUEST_INFO_WORLD_QUEST:
        case QUEST_INFO_WORLD_QUEST_EPIC:
        case QUEST_INFO_WORLD_QUEST_ELITE:
        case QUEST_INFO_WORLD_QUEST_RARE_ELITE:
        case QUEST_INFO_WORLD_QUEST_PVP:
        case QUEST_INFO_WORLD_QUEST_FIRST_AID:
        case QUEST_INFO_WORLD_QUEST_BATTLEPET:
        case QUEST_INFO_WORLD_QUEST_BLACKSMITHING:
        case QUEST_INFO_WORLD_QUEST_LEATHERWORKING:
        case QUEST_INFO_WORLD_QUEST_ALCHEMY:
        case QUEST_INFO_WORLD_QUEST_HERBALISM:
        case QUEST_INFO_WORLD_QUEST_MINING:
        case QUEST_INFO_WORLD_QUEST_TAILORING:
        case QUEST_INFO_WORLD_QUEST_ENGINEERING:
        case QUEST_INFO_WORLD_QUEST_ENCHANTING:
        case QUEST_INFO_WORLD_QUEST_SKINNINg:
        case QUEST_INFO_WORLD_QUEST_JEWELCRAFTING:
        case QUEST_INFO_WORLD_QUEST_INSCRIPTION:
        case QUEST_INFO_WORLD_QUEST_ARCHEOLOGY:
        case QUEST_INFO_WORLD_QUEST_FISHING:
        case QUEST_INFO_WORLD_QUEST_COOKING:
        case QUEST_INFO_WORLD_QUEST_RARE_2:
        case QUEST_INFO_WORLD_QUEST_RARE_ELITE_2:
        case QUEST_INFO_WORLD_QUEST_DUNGEON:
            return true;
        default:
            break;
    }

    return false;
}

bool Quest::IsAllowedInRaid(Difficulty difficulty) const
{
    if (IsRaidQuest(difficulty))
        return true;

    return sWorld->getBoolConfig(CONFIG_QUEST_IGNORE_RAID);
}

uint32 Quest::CalculateHonorGain(uint8 /*level*/) const
{
    uint32 honor = 0;

    /*if (GetRewHonorAddition() > 0 || GetRewHonorMultiplier() > 0.0f)
    {
        // values stored from 0.. for 1...
        TeamContributionPointsEntry const* tc = sTeamContributionPointsStore.LookupEntry(level);
        if (!tc)
            return 0;

        honor = uint32(tc->value * GetRewHonorMultiplier() * 0.1f);
        honor += GetRewHonorAddition();
    }*/

    return honor;
}

bool Quest::CanIncreaseRewardedQuestCounters() const
{
    // Dungeon Finder/Daily/Repeatable (if not weekly, monthly or seasonal) quests are never considered rewarded serverside.
    // This affects counters and client requests for completed quests.
    return (!IsDFQuest() && !IsDaily() && (!IsRepeatable() || IsWeekly() || IsMonthly() || IsSeasonal()));
}
