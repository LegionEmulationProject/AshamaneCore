-- Emissary Auldbridge SAI

SET @CGUID := 602000;

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=111109;
UPDATE `creature` SET `guid`=@CGUID+0, `PhaseId`=7138 WHERE `guid`=20555653;

-- Conditions
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 7138, 7502, 0, 0, 47, 0, 44663, 64, 0, 1, 'Allow phase 7138 if quest NOT Rewarded'),
(26, 7138, 7502, 0, 0, 47, 0, 44184, 64, 0, 1, 'Allow phase 7138 if quest NOT Rewarded');

-- Creature Text
DELETE FROM `creature_text` WHERE `CreatureID` = 111109;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(111109, 0, 0, 'The resources of Dalaran are at your disposal. From here, heroes of Alliance and Horde alike will search for the Pillars of Creation!', 12, 0, 100, 1, 0, 0, 123007, 0, 'Emissary Auldbridge to Player'),
(111109, 1, 0, 'I\'ve heard rumors of powerful artifacts that may be of use in your campaign. Keep an eye out and a useful lead just might present itself!', 12, 0, 100, 1, 0, 0, 123008, 0, 'Emissary Auldbridge to Player'),
(111109, 2, 0, 'Now I must attend to other visitors. Good luck, $n!', 12, 0, 100, 1, 0, 0, 123009, 0, 'Emissary Auldbridge to Player');

-- SAI
DELETE FROM `smart_scripts` WHERE `entryorguid`=111109 AND `source_type`=0 AND `id`=12 AND `link`=13;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(111109, 0, 0, 0, 20, 0, 100, 0, 44663, 0, 0, 0, 80, 11110900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quest Rewarded - Actionlist'),
(111109, 0, 1, 0, 20, 0, 100, 0, 44184, 0, 0, 0, 80, 11110900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Quest Rewarded - Actionlist'),
(111109, 0, 2, 0, 40, 0, 100, 0, 21, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Waypoint Reached - Despawn in 2 seconds'),
(11110900, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Emissary Auldridge - Become personal clone'),
(11110900, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Emissary Auldridge - Speech to Invoker'),
(11110900, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Emissary Auldridge - Speech to Invoker'),
(11110900, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Emissary Auldridge - Speech to Invoker'),
(11110900, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 53, 0, 11110910, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Emissary Auldridge - Waypoints');

SET @PATH := 11110910;
DELETE FROM `waypoint_data` WHERE `id`= @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 0, -819.3715, 4410.2275, 737.8271, 0, 0),
(@PATH, 1, -809.2504, 4422.3345, 738.1977, 0, 0),
(@PATH, 2, -802.13367, 4432.3257, 738.4878, 0, 0),
(@PATH, 3, -794.15625, 4443.6704, 737.6981, 0, 0),
(@PATH, 4, -783.1233, 4459.316, 735.18695, 0, 0),
(@PATH, 5, -778.7274, 4468.6396, 734.3575, 0, 0),
(@PATH, 6, -776.01215, 4482.854, 732.82837, 0, 0),
(@PATH, 7, -781.4948, 4494.6963, 731.8157, 0, 0),
(@PATH, 8, -794.99304, 4508.3794, 730.99274, 0, 0),
(@PATH, 9, -805.8976, 4513.4673, 730.71796, 0, 0),
(@PATH, 10, -820.6268, 4525.252, 729.7963, 0, 0),
(@PATH, 11, -831.4705, 4534.684, 729.1168, 0, 0),
(@PATH, 12, -847.0382, 4546.311, 728.3229, 0, 0),
(@PATH, 13, -855.26215, 4555.4204, 727.88324, 0, 0),
(@PATH, 14, -859.99304, 4564.8613, 727.8631, 0, 0),
(@PATH, 15, -859.1875, 4572.367, 732.8302, 0, 0),
(@PATH, 16, -858.06946, 4582.4053, 739.97784, 0, 0),
(@PATH, 17, -857.46704, 4589.8394, 745.6363, 0, 0),
(@PATH, 18, -856.7639, 4595.3384, 748.9865, 0, 0),
(@PATH, 19, -855.881, 4603.6406, 749.44336, 0, 0),
(@PATH, 20, -854.55383, 4609.0884, 750.1897, 0, 0),
(@PATH, 21, -853.6228, 4616.6523, 749.64954, 0, 0);