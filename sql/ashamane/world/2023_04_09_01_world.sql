-- update emissary auldbridge
SET @CGUID := 650536;

UPDATE `creature` SET `guid`=@CGUID, `PhaseID`=7138 WHERE `guid`=@ORG_GUID;

DELETE FROM `creature_template_addon` WHERE `entry`=111109;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(111109, 0, 0, 0, 257, 0, 0, 0, 0, 0, ''); -- 111109 (Emissary Auldbridge)

DELETE FROM `phase_area` WHERE `PhaseId`=7138;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7502, 7138, 'See Emissary Auldbridge, welcoming in Broken Isles Dalaran');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 26) AND (`SourceGroup` IN (7138));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 7138, 7502, 0, 0, 28, 0, 44663, 0, 0, 0, 'Player has completed quest In the Blink of an Eye (44663) (but not yet rewarded)'),
(26, 7138, 7502, 0, 1, 28, 0, 44184, 0, 0, 0, 'Player has completed quest In the Blink of an Eye (44184) (but not yet rewarded)');