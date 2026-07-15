DELETE FROM `spell_target_position` WHERE `ID`=160404;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(160404, 0, 1116, 1948.4392, 327.6337, 89.04919, 3.4551287, 0);

DELETE FROM `spell_target_position` WHERE `ID`=160416;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(160416, 0, 1116, 1948.4392, 327.6337, 89.04919, 3.4551287, 0);

-- Lunarfall Guard 1
SET @LUNARFALL_GUARD_1 := 79394;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @LUNARFALL_GUARD_1;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @LUNARFALL_GUARD_1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@LUNARFALL_GUARD_1, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell - Target Self'),
(@LUNARFALL_GUARD_1, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 793940, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Link - Waypoints');

-- Waypoints Lunarfall Guard
SET @LUNARFALL_GUARD_1 := 79394;
SET @PATH := @LUNARFALL_GUARD_1 * 10;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`) VALUES
(@PATH, 1, 1938.96, 319.3212, 89.05704),
(@PATH, 2, 1938.137, 321.6996, 89.05704);

-- Lunarfall Guard 2
SET @LUNARFALL_GUARD_2 := 79422;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @LUNARFALL_GUARD_2;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @LUNARFALL_GUARD_2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@LUNARFALL_GUARD_2, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 42459, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On Respawn - Cast Spell - Target Self'),
(@LUNARFALL_GUARD_2, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 53, 0, 794220, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Link - Waypoints');

SET @PATH := @LUNARFALL_GUARD_2 * 10;
DELETE FROM `waypoints` WHERE `entry`= @PATH;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`) VALUES
(@PATH, 1, 1935.375, 317.7986, 89.10867),
(@PATH, 2, 1944.266, 321.4115, 89.05704),
(@PATH, 3, 1942.83, 324.184, 89.05704);
