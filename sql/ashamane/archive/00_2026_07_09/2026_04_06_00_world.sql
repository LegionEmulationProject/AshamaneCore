-- Update archmage khadgar at lunarfall
SET @CGUID := 500005;
UPDATE `creature` SET `PhaseId`=3695, `id`=@CGUID+0 WHERE `id`=10184457;

-- Phasing
DELETE FROM `phase_area` WHERE `AreaId`=7078 AND `PhaseId`=3695;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7078, 3695, 'Cosmetic - See Khadgar at Lunarfall Pre-Garrison');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup`=3695 AND `SourceEntry` = 7078);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3695, 7078, 0, 0, 47, 0, 34586, 66, 0, 1, 'Apply Phase 3695 if Quest 34586 is NOT Completed/Rewarded');
