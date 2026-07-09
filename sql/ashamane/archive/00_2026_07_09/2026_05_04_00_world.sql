SET @CGUID := 602002;
UPDATE `creature` SET `PhaseId`=5610, `guid`=@CGUID+0 WHERE `guid`=20544383;

DELETE FROM `phase_area` WHERE `AreaId` = 7502 AND `PhaseId` = 5610;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7502, 5610, 'See Archmage Khadgar at Krassus Landing. (Paradise Lost)');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26 AND `SourceGroup` = 5610 AND `SourceEntry` = 7502);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 5610, 7502, 0, 1, 47, 0, 39718, 8|2|64, 0, 0, 'Allow phase 5610 if Quest (39718) in progress, completed, rewarded'),
(26, 5610, 7502, 0, 1, 47, 0, 41220, 66, 0, 1, 'Allow phase 5610 if Quest (41220) is NOT completed | rewarded');
