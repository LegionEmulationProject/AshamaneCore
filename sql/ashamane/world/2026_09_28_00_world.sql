-- Add phase to Elothir in the grove of cenarius

SET @CGUID := 602056;
UPDATE `creature` SET `PhaseId`=4571, `guid`=@CGUID+0 WHERE `guid`=20535552;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7601 AND `PhaseId` = 4571;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 4571, 'Cosmetic - Elothir - Grove of Cenarius');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 4571 AND `SourceEntry` = 7601);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4571, 7601, 0, 1, 47, 0, 38322, 64, 0, 0, 'Allow phase 4570 if Quest (38322) IS rewarded'),
(26, 4571, 7601, 0, 1, 47, 0, 38663, 64, 0, 1, 'Allow phase 4570 if Quest (38663) IS NOT rewarded');
