DELETE FROM `spell_target_position` WHERE `ID`=165275;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(165275, 0, 1116, 1948.4392, 327.6337, 89.04919, 4.3630238, 0);

SET @BRIGHTSTONE := 82150;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @BRIGHTSTONE;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @BRIGHTSTONE;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@BRIGHTSTONE, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 821500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Waypoints');

SET @PATH := @BRIGHTSTONE * 10;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`) VALUES
(@PATH, 1, 1955.851, 308.9271, 90.29825),
(@PATH, 2, 1962.738, 314.6285, 90.05704),
(@PATH, 3, 1955.943, 337.441, 88.68378),
(@PATH, 4, 1961.78, 337.6302, 89.11139),
(@PATH, 5, 1970.542, 337.132, 89.06053),
(@PATH, 6, 1977.269, 333.5, 89.31053),
(@PATH, 7, 1978.674, 330.0799, 89.46582),
(@PATH, 8, 1975.87, 323.8941, 89.66101),
(@PATH, 9, 1970.58, 324.2639, 89.3988),
(@PATH, 10, 1969.148, 326.6007, 89.08618);
