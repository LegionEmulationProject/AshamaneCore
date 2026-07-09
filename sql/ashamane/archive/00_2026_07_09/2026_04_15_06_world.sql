SET @CGUID :=500035;
UPDATE `creature` SET `PhaseId`=3764, `guid`=@CGUID+0 WHERE `guid`=10124220;

DELETE FROM `creature_template_addon` WHERE `entry` IN (81696 /*81696 (Teron'gor) - Fel Prison*/);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(81696, 0, 0, 0, 3, 0, 1, 0, 0, 6592, 0, 0, 0, '166539'); -- 81696 (Teron'gor) - Fel Prison