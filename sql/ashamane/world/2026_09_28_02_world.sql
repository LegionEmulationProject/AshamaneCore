-- Add phase to Ysera in the grove of cenarius.

SET @CGUID := 602058;
UPDATE `creature` SET `PhaseId`=5506, `guid`=@CGUID+0 WHERE `guid`=20535556;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7601 AND `PhaseId` = 5506;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 5506, 'Cosmetic - Ysera - Grove of Cenarius');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 5506 AND `SourceEntry` = 7601);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 5506, 7601, 0, 1, 47, 0, 38322, 2|64, 0, 0, 'Allow phase 5506 if Quest (38322) IS completed | rewarded'),
(26, 5506, 7601, 0, 1, 47, 0, 38663, 2|8|64, 0, 1, 'Allow phase 5506 if Quest (38663) IS NOT taken | completed | rewarded');
