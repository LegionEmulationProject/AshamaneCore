DELETE FROM `smart_scripts` WHERE `entryorguid`=-303171;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (-112661, -112656, -111478, -111477);

UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (314, 335, 441, 787, 891, 910, 951, 1009, 1118, 1123, 1166,
1181, 1183, 1393, 1397, 1867, 1915, 1920, 2003, 2120, 2244, 2272, 2276, 2305, 2306, 2335, 2346, 2359, 2387, 2415, 2428, 4063,
5251, 6002, 6221, 7043, 7070, 7075, 7664, 7666, 7667, 7956, 8147, 11878, 14390, 15945);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (52357, 52356);