SET @CGUID :=500034;
UPDATE `creature` SET `PhaseId`=3763, `guid`=@CGUID+0 WHERE `guid`=1385258;

DELETE FROM `creature_template_addon` WHERE `entry` IN (81695 /*81695 (Cho'gall) - Fel Prison*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(81695, 0, 0, 0, 3, 0, 1, 0, 0, 6591, 0, 0, 0, '166539'); -- 81695 (Cho'gall) - Fel Prison