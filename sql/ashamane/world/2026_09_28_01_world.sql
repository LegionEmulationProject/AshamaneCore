-- Add phase to koda steelclaw in the grove of cenarius

SET @CGUID := 602057;
UPDATE `creature` SET `PhaseId`=4570, `guid`=@CGUID+0 WHERE `guid`=20535553;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7601 AND `PhaseId` = 4570;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 4570, 'Cosmetic - Koda Steelclaw - Grove of Cenarius');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 4570 AND `SourceEntry` = 7601);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4570, 7601, 0, 1, 47, 0, 38147, 64, 0, 0, 'Allow phase 4570 if Quest (38147) IS rewarded'),
(26, 4570, 7601, 0, 1, 47, 0, 38663, 64, 0, 1, 'Allow phase 4570 if Quest (38663) IS NOT rewarded');
