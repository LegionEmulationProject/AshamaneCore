-- Update phase & guid for archmage khadgar.
SET @CGUID := 500006;
UPDATE `creature` SET `PhaseId`=3563, `guid`=@CGUID+0 WHERE `guid`=1383287;

-- Phase
DELETE FROM `phase_area` WHERE `AreaId` = 7037 AND `PhaseId` = 3563;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7037, 3563, 'See Khadgar at the Dark Portal (Assault on the Dark Portal)');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3563 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3563, 7037, 0, 0, 47, 0, 34393, 0x2|0x64, 0, 1, 'Apply Phase 3563 if Quest 34393 is NOT Completed/Rewarded');