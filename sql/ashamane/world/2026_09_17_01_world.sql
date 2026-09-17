-- Update malfurion in lorlathil with correct phase

SET @CGUID := 602052;

UPDATE `creature` SET `PhaseId`=4549, `guid`=@CGUID+0 WHERE `guid`=20533880;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7600 AND `PhaseId` = 4549;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7600, 4549, 'Cosmetic - Malfurion Stormrage - Lorlathil');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 4549 AND `SourceEntry` = 7600);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4549, 7600, 0, 1, 47, 0, 40122, 2|64, 0, 1, 'Allow phase 4549 if Quest (40122) IS NOT Completed or rewarded');
