UPDATE `creature_template` SET `VehicleId`=4499, `AIName`='', `ScriptName`='npc_hippogryph_100483' WHERE `entry`=100483;
UPDATE `creature_template` SET `gossip_menu_id`=18723, `AIName`='SmartAI' WHERE `entry`=96813;

DELETE FROM `smart_scripts` WHERE `entryorguid`=96813;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(96813, 0, 0, 1, 62, 0, 100, 0, 18723, 1, 0, 0, 85, 197754, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Gossip Select - Invoke Summon Hippogryph'),
(96813, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Link - Speech to Player');

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=18723;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15, 18723, 1, 0, 0, 28, 0, 39861, 0, 0, 1, 0, 0, '', 'Show gossip option if player has not completed quest 39861');

-- Creature Text
DELETE FROM `creature_text` WHERE `CreatureId`=96813;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(96813, 0, 0, 'I have just the beast for this special task.', 12, 0, 100, 0, 0, 0, 0, 0, 'Aludane Whitecloud to Player');

DELETE FROM `waypoint_data` WHERE `id`= 100483;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(100483, 0, -860.41144, 4295.771, 748.9592),
(100483, 1, -835.6389, 4233.6665, 777.28436),
(100483, 2, -810.0156, 4154.627, 792.4261),
(100483, 3, -705.27606, 4140.002, 803.95135),
(100483, 4, -592.92017, 4216.955, 803.95135),
(100483, 5, -522.5573, 4368.5713, 803.95135),
(100483, 6, -497.49652, 4539.2144, 681.57904),
(100483, 7, -437.64932, 4608.243, 607.4223),
(100483, 8, -442.5764, 4732.401, 445.14838),
(100483, 9, -330.87152, 4951.3145, 225.81961),
(100483, 10, -91.739586, 5162.9775, 225.81961),
(100483, 11, 196.69444, 5345.738, 225.81961),
(100483, 12, 417.3264, 5502.4316, 225.81961),
(100483, 13, 839.49304, 5785.723, 225.81961),
(100483, 14, 1068.7327, 5927.224, 225.81961),
(100483, 15, 1206.3351, 5971.9985, 225.81961),
(100483, 16, 1373.981, 6030.1494, 225.81961),
(100483, 17, 1898.3663, 6249.382, 225.81961),
(100483, 18, 2072.0051, 6342.8394, 218.07954),
(100483, 19, 2115.467, 6375.9644, 205.98737),
(100483, 20, 2175.6946, 6411.2476, 191.25554),
(100483, 21, 2231.29, 6427.79, 191.58113),
(100483, 22, 2362.3923, 6519.6235, 205.98737),
(100483, 23, 2301.8213, 6573.0703, 148.32352);
