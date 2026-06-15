UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_archmage_khadgar_93337' WHERE `entry`=93337;
UPDATE `quest_template_addon` SET `ScriptName`='quest_into_the_fray' WHERE `id` IN (44137, 38834);

DELETE FROM `script_waypoint` WHERE `entry`=93337;
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`) VALUES
(93337, 1, -78.3393, 6858.93, 31.0119),
(93337, 2, -81.4901, 6880.0, 23.6468),
(93337, 3, -80.4822, 6885.37, 21.999),
(93337, 4, -74.7649, 6899.0, 17.9561),
(93337, 5, -73.2156, 6906.45, 16.512),
(93337, 6, -73.6964, 6909.42, 16.0559),
(93337, 7, -76.6878, 6919.45, 15.2145);

DELETE FROM `spell_target_position` WHERE `ID`=184775;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(184775, 0, 1220, -79.12674, 6859.221, 31.14276, 2.2863812, 0); -- Into the Fray: Summon Archmage Khadgar

DELETE FROM `creature_text` WHERE `CreatureID` IN (89362, 93325);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(89362, 0, 0, 'Archmage Khadgar? $n? An unexpected surprise.', 12, 0, 100, 6, 0, 52717, 0, 0, 'Kayn Sunfury to Player'),
(89362, 1, 0, 'Nice weapon you have there, $n. Speak with Jace and Allari if you\'d like to help.', 12, 0, 100, 396, 0, 52715, 0, 0, 'Kayn Sunfury to Player'),
(93325, 0, 0, 'Hurry. The Illidari are about to be overrun.', 12, 0, 100, 397, 0, 52607, 0, 0, 'Archmage Khadgar to Player');
