SET @CGUID := 700078;

-- Creature
UPDATE `creature` SET `PhaseId`=1687, `guid`=@CGUID+0 WHERE `guid`=10645558;

UPDATE `creature_template` SET `BaseAttackTime`=2000, `unit_flags`=33024, `unit_flags2`=2048 WHERE `entry`=55789; -- Rell Nightwind

-- Phasing
DELETE FROM `phase_area` WHERE `AreaId` = 1519 AND `PhaseId` = 1687;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(1519, 1687, 'Cosmetic - See Rell Nightwind');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 1687 AND `SourceEntry` = 1519);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 1687, 1519, 0, 0, 47, 0, 49556, 64, 0, 0, 'Allow Phase 1687 if Quest (49556) IS completed'),
(26, 1687, 1519, 0, 0, 47, 0, 29547, 64, 0, 0, 'Allow Phase 1687 if Quest (29547) IS completed');

-- Quest
DELETE FROM `quest_template_addon` WHERE `ID` IN (29547);
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`, `ScriptName`) VALUES
(29547, 0, 0, 0, 49556, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `quest_offer_reward` WHERE `ID`IN (29547, 49556);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(49556, 396, 0, 0, 0, 0, 0, 0, 0, 'Greetings, $n.', 26972), -- Hero's Call: Jade Forest!
(29547, 396, 0, 0, 0, 0, 0, 0, 0, 'Greetings, $n.', 26972); -- The King's Command

DELETE FROM `creature_questender` WHERE (`id`=55789 AND `quest`=49556);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(55789, 49556); -- Hero's Call: Jade Forest! ended by Rell Nightwind
