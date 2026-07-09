SET @CGUID := 500036;
UPDATE `creature` SET `PhaseId`=3251, `guid`=@CGUID+0 WHERE `guid`=1383274;

DELETE FROM `creature_template_addon` WHERE `entry` = 78333;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(78333, 0, 0, 0, 0, 0, 1, 0, 416, 0, 0, 0, 0, '178274'); -- 78333 (Gul'dan) - Gul'dan SFX