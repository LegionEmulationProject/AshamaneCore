SET @OGUID := 500000;

UPDATE `gameobject` SET `PhaseId`=4200, `guid`=@OGUID+0 WHERE `guid`=1250120;
UPDATE `gameobject` SET `PhaseId`=4201, `guid`=@OGUID+1 WHERE `guid`=1250112;

DELETE FROM `phase_area` WHERE `AreaId`=7025 AND `PhaseId`IN (4200, 4201);
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7025, 4200, 'Dark Portal Intact on Tanaan Jungle (Assault on the Dark Portal)'),
(7025, 4201, 'Dark Portal Destroyed on Tanaan Jungle (Assault on the Dark Portal)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4200 AND `SourceEntry` = 7025);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4200, 7025, 0, 0, 47, 0, 34445, 2 | 64, 0, 1, 'Apply Phase 4200 if Quest 34445 is not complete | rewarded');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4201 AND `SourceEntry` = 7025);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4201, 7025, 0, 0, 47, 0, 34445, 2 | 64, 0, 0, 'Apply Phase 4201 if Quest 34445 is complete | rewarded');


UPDATE `gameobject_template_addon` SET `flags`=1048608 WHERE `entry` IN (237670, 237667);