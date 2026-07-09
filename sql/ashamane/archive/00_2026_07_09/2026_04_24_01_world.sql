-- Update phase and guid for The Skyfire in Stormwind Harbor for End of Battle for Broken shore & Stormheim

SET @OGUID := 600007;

UPDATE `gameobject` SET `phaseId`=6821, `guid`=@OGUID+0 WHERE `guid`=20373184;
UPDATE `gameobject_addon` SET `guid`=@OGUID+0 WHERE `guid`=20373184;

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=26 AND `SourceGroup`=6821 AND `SourceEntry`=1519;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 6821, 1519, 0, 0, 47, 0, 42740, 66, 0, 0, 'Allow phase 6821 if quest Completed | Rewarded'), -- Battle for Brokenshore
(26, 6821, 1519, 0, 0, 47, 0, 40517, 64, 0, 1, 'Allow phase 6821 if quest is NOT Rewarded'), -- The Fallen Lion
(26, 6821, 1519, 0, 0, 47, 0, 38035, 2 | 8 | 66, 0, 0, 'Allow phase 6821 if quest Inprogress | Completed | Rewarded'), -- A Royal Summons
(26, 6821, 1519, 0, 0, 47, 0, 39800, 66, 0, 1, 'Allow phase 6821 if quest NOT Completed or Rewarded'); -- Greymane's Gambit

-- Phase Area
DELETE FROM `phase_area` WHERE `AreaId` = 1519 AND `PhaseId` = 6821;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(1519, 6821, 'Cosmetic: See The Skyfire in Stormwind Harbor');

