-- Update malfurion in grove of cenarius after the emerald queen with correct phase

SET @CGUID := 602055;

UPDATE `creature` SET `PhaseId`=4572, `guid`=@CGUID+0 WHERE `guid`=20535555;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7601 AND `PhaseId` = 4572;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 4572, 'Cosmetic - Malfurion Stormrage - Grove of Cenarius');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 4572 AND `SourceEntry` = 7601);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4572, 7601, 0, 1, 47, 0, 38377, 2|64, 0, 0, 'Allow phase 4572 if Quest (38377) IS Completed and rewarded'),
(26, 4572, 7601, 0, 1, 47, 0, 38663, 2|64, 0, 1, 'Allow phase 4572 if Quest (38663) IS NOT Completed or rewarded');
