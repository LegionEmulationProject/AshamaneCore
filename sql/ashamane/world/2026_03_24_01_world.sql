-- Add correct phases to npcs at eventide bay in shadowmoon valley & update guid

SET @CGUID := 500000;

UPDATE `creature` SET `PhaseId`=3329, `guid`=@CGUID+0 WHERE `guid`=10184380;
UPDATE `creature` SET `PhaseId`=3329, `guid`=@CGUID+1 WHERE `guid`=10184368;
UPDATE `creature` SET `PhaseId`=3329, `guid`=@CGUID+2 WHERE `guid`=10184366;
UPDATE `creature` SET `PhaseId`=3329, `guid`=@CGUID+3 WHERE `guid`=10184367;
UPDATE `creature` SET `PhaseId`=3329, `guid`=@CGUID+4 WHERE `guid`=10184384;

-- Phasing
DELETE FROM `phase_area` WHERE `AreaId`=6719 AND `PhaseId`=3353;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES 
(6719, 3329, 'Cosmetic - Follow Velen Complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup`=3329 AND `SourceEntry` = 6719);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3329, 6719, 0, 0, 47, 0, 34582, 0, 0, 0, 'Apply Phase 3329 if Quest 34582 is NOT Taken');
