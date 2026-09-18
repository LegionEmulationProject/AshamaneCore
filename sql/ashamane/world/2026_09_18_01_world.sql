-- Update nyandra springbloom in grove of cenarius with correct phase

SET @CGUID := 602054;

UPDATE `creature` SET `PhaseId`=5490, `guid`=@CGUID+0 WHERE `guid`=20533956;

-- Phase 
DELETE FROM `phase_area` WHERE `AreaId` = 7601 AND `PhaseId` = 5490;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7601, 5490, 'Cosmetic - Malfurion Stormrage - Lorlathil');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 5490 AND `SourceEntry` = 7601);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 5490, 7601, 0, 1, 47, 0, 40122, 64, 0, 0, 'Allow phase 5490 if Quest (40122) IS rewarded'),
(26, 5490, 7601, 0, 1, 47, 0, 38235, 2|8|64, 0, 1, 'Allow phase 5490 if Quest (38235) IS NOT Taken | Completed | Rewarded');