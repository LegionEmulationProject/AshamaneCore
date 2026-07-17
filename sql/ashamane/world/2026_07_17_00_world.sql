DELETE FROM `spell_target_position` WHERE `ID`=165278;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(165278, 0, 1116, 1948.4392, 327.6337, 89.04919, 3.2414088, 0);

-- Starfall Sentinel
SET @STARFALL_SENTINEL := 82154;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @STARFALL_SENTINEL;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @STARFALL_SENTINEL;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@STARFALL_SENTINEL, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 821540, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Waypoints'),
(@STARFALL_SENTINEL, 0, 1, 0, 40, 0, 100, 0, 9, 0, 0, 0, 0, 41, 0, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Waypoint ID Reached - Despawn in 10s');

SET @PATH := @STARFALL_SENTINEL * 10;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`) VALUES
(@PATH, 1, 1918.208, 319.1823, 89.87404),
(@PATH, 2, 1916.8, 307.9271, 90.13783),
(@PATH, 3, 1914.097, 300.467, 89.49904),
(@PATH, 4, 1910.701, 295.6476, 89.16872),
(@PATH, 5, 1886.842, 269.5851, 77.50237),
(@PATH, 6, 1884.059, 262.4514, 78.0463),
(@PATH, 7, 1885.944, 249.4288, 77.94584),
(@PATH, 8, 1881.75, 234.8906, 77.69584),
(@PATH, 9, 1867.988, 225.0521, 77.41692);
