-- Add correct phase to Tormented Soul spawns and update guid

SET @CGUID := 500009;

UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+0 WHERE `guid`=10124214;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+1 WHERE `guid`=10124213;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+2 WHERE `guid`=10124212;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+3 WHERE `guid`=10124210;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+4 WHERE `guid`=10124209;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+5 WHERE `guid`=10124207;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+6 WHERE `guid`=10124206;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+7 WHERE `guid`=10124205;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+8 WHERE `guid`=10124204;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+9 WHERE `guid`=10124203;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+10 WHERE `guid`=10124202;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+11 WHERE `guid`=10124201;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+12 WHERE `guid`=10124200;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+13 WHERE `guid`=10124199;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+14 WHERE `guid`=10124198;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+15 WHERE `guid`=10124197;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+16 WHERE `guid`=10124196;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+17 WHERE `guid`=10124193;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+18 WHERE `guid`=10124192;
UPDATE `creature` SET `PhaseId`=3568, `guid`=@CGUID+19 WHERE `guid`=10124191;

-- Phase
DELETE FROM `phase_area` WHERE `AreaId` = 7037 AND `PhaseId` = 3568;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7037, 3568, 'See the Battle for the Dark Portal (Assault on the Dark Portal)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3568 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3568, 0, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3568 if Quest 34393 is not complete | rewarded');