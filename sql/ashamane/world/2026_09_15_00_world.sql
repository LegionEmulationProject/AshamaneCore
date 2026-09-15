UPDATE `creature_template` SET `ScriptName`='npc_malfurion_stormrage_91465' WHERE `entry`=91465;

DELETE FROM `creature_text` WHERE `CreatureID`=91465;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(91465, 0, 0, 'Ahh, Val\'sharah...', 12, 0, 100, 1, 0, 52735, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(91465, 1, 1, 'Every step in this forest brings back precious memories.', 12, 0, 100, 0, 0, 52358, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(91465, 2, 2, 'Ages ago, the first druids molded this land to be a reflection of the Emerald Dream.', 12, 0, 100, 0, 0, 52359, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(91465, 3, 3, 'Merely an echo, but Val\'sharah is as close to the Dream as this world can come.', 12, 0, 100, 0, 0, 52360, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(91465, 4, 4, 'Make ready, hero. We shall soon stand in the presence of the Lord of the Forest.', 12, 0, 100, 0, 0, 52277, 0, 0, 'Malfurion Stormrage to Malfurion Stormrage'),
(91465, 5, 5, 'Follow me.', 12, 0, 100, 0, 0, 52741, 0, 0, 'Malfurion Stormrage to Player');
