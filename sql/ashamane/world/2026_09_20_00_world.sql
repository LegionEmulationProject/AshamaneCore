-- Update malfurion in grove of cenarius with correct phase

SET @CGUID := 602053;

UPDATE `creature` SET `PhaseId`=4550, `guid`=@CGUID+0 WHERE `guid`=20536129;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7601 AND `PhaseId` = 4550;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 4550, 'Cosmetic - Malfurion Stormrage - Grove of Cenarius');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 4550 AND `SourceEntry` = 7601);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4550, 7601, 0, 1, 47, 0, 40122, 64, 0, 0, 'Allow phase 4550 if Quest (40122) IS rewarded'),
(26, 4550, 7601, 0, 1, 47, 0, 38377, 2|64, 0, 1, 'Allow phase 4550 if Quest (38377) IS NOT Completed or rewarded');