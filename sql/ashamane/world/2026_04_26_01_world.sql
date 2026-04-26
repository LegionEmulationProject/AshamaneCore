-- Combined SQL extracted from pure database commits in PR #5.
-- Scope: master/Legion SQL only. 3.3.5 / 335-branch SQL files are skipped.
-- Repository: https://github.com/LegionEmulationProject/AshamaneCore
-- Source PR: https://github.com/LegionEmulationProject/AshamaneCore/pull/5/commits
-- Extraction rule: only added lines from non-335 .sql files in each selected commit patch.
-- Review before applying to production. This file intentionally does not wrap everything in a transaction.


-- ============================================================================
-- 01. 74818fe - DB/Misc: Fix startup errors / typo fix
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/74818fe
-- ============================================================================
--
SET @CGUID := 146562;
SET @OGUID := 9743;


DELETE FROM `game_event_creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+62 AND `eventEntry`=8;
INSERT INTO `game_event_creature` SELECT 8, creature.guid FROM `creature` WHERE creature.guid BETWEEN @CGUID+0 AND @CGUID+62;

DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+94 AND `eventEntry`=8;
DELETE FROM `game_event_gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+94 AND `eventEntry`=8;
INSERT INTO `game_event_gameobject` SELECT 8, gameobject.guid FROM `gameobject` WHERE gameobject.guid BETWEEN @OGUID+0 AND @OGUID+94;
--

-- ============================================================================
-- 02. 498b0a0 - DB/Creature: Doctor Razorgrin
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/498b0a0
-- ============================================================================
-- 
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=45872;
INSERT INTO conditions (SourceTypeOrReferenceId, SourceGroup, SourceEntry, SourceId, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, ConditionValue2, ConditionValue3, NegativeCondition, ErrorType, ErrorTextId, ScriptName, COMMENT) VALUES
(13, 1, 45872, 0, 0, 31, 0, 3, 23837, 0, 0, 0, 0, '', 'Defibrillate');

SET @ENTRY := 25678;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,4,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Doctor Razorgin - On Aggro - Say Line 0 (random)'),
(@ENTRY,0,1,2,1,0,100,0,3000,3000,30000,30000,11,45872,0,0,0,0,0,1,0,0,0,0,0,0,0,'Doctor Razorgin - OOC - Cast Defibrillate'),
(@ENTRY,0,2,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Doctor Razorgin - Ooc - Say Line 1 (random)');

DELETE FROM `creature_text` WHERE `CreatureID`=@ENTRY;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`comment`,`BroadcastTextId`) VALUES
(@ENTRY,0,0,'Ah, good... more parts!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines',24872),
(@ENTRY,0,1,'Fresh meat!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines',24871),
(@ENTRY,0,2,'The doctor is in!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines',24870),
(@ENTRY,0,3,'I recommened evisceration!',14,0,100,0,0,0,'Part of the Doctor Razorgin on aggro lines',24873),
(@ENTRY,1,0,'Clear!',14,0,100,0,0,0,'Part of the Doctor Razorgin ooc lines',24867),
(@ENTRY,1,1,'It''s no good... you need more work first.',14,0,100,0,0,0,'Part of the Doctor Razorgin ooc lines',24869),
(@ENTRY,1,2,'Live, damn you!',14,0,100,0,0,0,'Part of the Doctor Razorgin ooc lines',24868);

UPDATE `creature` SET `position_x`=4402.431152, `position_y`=4554.557129, `position_z`=88.743332, `orientation`=0.395920, `MovementType`=0, `wander_distance`=0 WHERE `id`=@ENTRY;

-- ============================================================================
-- 03. 4470689 - Rename 2017_03_25_00_world.sql to 2017_03_25_01_world.sql
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/4470689
-- ============================================================================
DELETE FROM `trinity_string` WHERE `entry`=530;

-- ============================================================================
-- 04. a243c25 - DB/Creature: Fix Guardian of Icecrown creature_text typo
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/a243c25
-- ============================================================================
--
UPDATE `creature_text` SET `Text`= "%s flees after seeing Kel'Thuzad fall!" WHERE `CreatureID`= 16441 AND `GroupID`= 0;

-- ============================================================================
-- 05. f305c76 - DB/Creature: Fix Verifonix faction and reputation
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/f305c76
-- ============================================================================
-- No executable SQL additions extracted from this commit.
-- This is likely a rename-only SQL commit, metadata-only change, or 335-only SQL change.

-- ============================================================================
-- 06. 5783117 - DB/Item: Improved Land Mines
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/5783117
-- ============================================================================
-- Improved Land Mine SAI
SET @ENTRY := 29475;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,89,0,0,0,0,0,0,1,0,0,0,0,0,0,0,"Improved Land Mine - On Reset - Start Random Movement"),
(@ENTRY,0,1,2,60,0,100,0,0,0,1000,1000,11,54537,0,0,0,0,0,1,0,0,0,0,0,0,0,"Improved Land Mine - On Update - Cast 'Detonation'"),
(@ENTRY,0,2,0,61,0,100,0,0,0,1000,1000,41,500,0,0,0,0,0,1,0,0,0,0,0,0,0,"Improved Land Mine - On Update - Despawn In 500 ms"),
(@ENTRY,0,3,0,5,0,100,0,0,0,0,29618,33,29618,0,0,0,0,0,21,50,0,0,0,0,0,0,"Improved Land Mine - On Killed Unit - Update Quest Kill Credit for 'A Delicate Touch' or 'Overstock'"),
(@ENTRY,0,4,0,5,0,100,0,0,0,0,29619,33,29618,0,0,0,0,0,21,50,0,0,0,0,0,0,"Improved Land Mine - On Killed Unit - Update Quest Kill Credit for 'A Delicate Touch' or 'Overstock'");
--

-- ============================================================================
-- 07. 3656e47 - DB/Quest: Challenge Overlord Mok'Morokk
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/3656e47
-- ============================================================================
-- Quest 27418, Challenge Overlord Mok'Morokk

SET @OMM := 4500; -- Overlord Mok'Morokk

UPDATE `quest_template_addon` SET `SpecialFlags`=2 WHERE  `ID`=1173;

DELETE FROM `creature_text` WHERE `CreatureID`= @OMM;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@OMM, 0,0,'Puny $r wanna fight Overlord Mok''Morokk? Me beat you! Me boss here!',12,0,100,0,0,0,1515,0,'Overlord Mok''Morokk - on Quest Accept'),
(@OMM, 1,0,'Me scared! Me run now!',                                              14,0,100,0,0,0,1523,0,'Overlord Mok''Morokk - on Health 0%-25%');

DELETE FROM `waypoints` WHERE `entry` = @OMM;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(@OMM, 1, -3138.49, -2864.64, 34.76, 'Overlord Mok''Morokk'),
(@OMM, 2, -3128.08, -2847.37, 34.72, 'Overlord Mok''Morokk'),
(@OMM, 3, -3108.94, -2839.60, 34.28, 'Overlord Mok''Morokk');

UPDATE `creature_template` SET `AIName` = "SmartAI", `ScriptName` = '' WHERE `entry` = @OMM;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@OMM, @OMM*100, @OMM*100+1);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@OMM,      0, 0,0,  0,0,100,0, 1000,3000,7000,10000, 11,      6749,   2, 0,0,0,0,  2, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - In Combat Update - cast ''Wide Swipe'''),
(@OMM,      0, 1,2, 19,0,100,1, 1173,   0,   0,    0, 64,         1,   0, 0,0,0,0, 16, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Quest Accept - Store players (No repeat)'),
(@OMM,      0, 2,0, 61,0,100,0,    0,   0,   0,    0, 80,  @OMM*100,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Quest Accept - Run Actionlist 450000'),
(@OMM*100,  9, 0,0,  0,0,100,0, 3000,3000,   0,    0,  1,         0,   0, 0,0,0,0, 12, 1,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Say text 0'),
(@OMM*100,  9, 1,0,  0,0,100,0,    0,   0,   0,    0,  2,        16,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Set faction (Monster)'),
(@OMM*100,  9, 2,0,  0,0,100,0,    0,   0,   0,    0, 83,         2,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Remove npcflag Quest Giver'),
(@OMM*100,  9, 3,0,  0,0,100,0,    0,   0,   0,    0, 19,       768,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Remove Unit Flags immune to NPC & immune to PC'),
(@OMM*100,  9, 4,0,  0,0,100,0,    0,   0,   0,    0, 49,         0,   0, 0,0,0,0, 12, 1,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Attack stored player'),
(@OMM,      0, 3,0,  2,0,100,1,    0,  25,   0,    0, 80,@OMM*100+1,   2, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Health 0%-25% - Run Actionlist 450001 (No repeat)'),
(@OMM,      0, 4,0,  0,0,100,1,    0,   0,   0,    0, 42,         0,   1, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - In Combat - Set invincibility hp level (No repeat)'),
(@OMM*100+1,9, 0,0,  0,0,100,0,    0,   0,   0,    0, 18,       768,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Set Unit Flags immune to NPC & immune to PC'),
(@OMM*100+1,9, 1,0,  0,0,100,0,    0,   0,   0,    0, 28,         0,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Remove all auras'),
(@OMM*100+1,9, 2,0,  0,0,100,0,    0,   0,   0,    0,  2,        29,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Set faction (Orgrimmar)'),
(@OMM*100+1,9, 3,0,  0,0,100,0,    0,   0,   0,    0, 24,         0,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Evade'),
(@OMM*100+1,9, 4,0,  0,0,100,0,    0,   0,   0,    0, 15,      1173,   0, 0,0,0,0, 12, 1,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Credit Quest ''Challenge Overlord Mok''Morokk'''),
(@OMM*100+1,9, 5,0,  0,0,100,0,  500, 500,   0,    0,  1,         1,   0, 0,0,0,0, 12, 1,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Say text 1'),
(@OMM*100+1,9, 6,0,  0,0,100,0,    0,   0,   0,    0, 53,         1,@OMM, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - Actionlist - Start Waypoint'),
(@OMM,      0, 5,0, 58,0,100,0,    0,@OMM,   0,    0, 41,         0,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on WP End - Despawn'),
(@OMM,      0, 6,7, 25,0,100,0,    0,   0,   0,    0, 18,       768,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Reset - Set Unit Flags immune to NPC & immune to PC'),
(@OMM,      0, 7,8, 61,0,100,0,    0,   0,   0,    0, 82,         2,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Reset - Remove all auras'),
(@OMM,      0, 8,0, 61,0,100,0,    0,   0,   0,    0,  2,        29,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Reset - Set faction (Orgrimmar)'),
(@OMM,      0, 9,0, 11,0,100,0,    0,   0,   0,    0, 42,         1,   0, 0,0,0,0,  1, 0,0,0,0,0,0,0,'Overlord Mok''Morokk - on Spawn - Set Invincibility at 1 HP');
--

-- ============================================================================
-- 08. d8e4205 - DB: Fix Some DB errors
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/d8e4205
-- ============================================================================
-- 
UPDATE `smart_scripts` SET `action_type`=11, `action_param1`=54693, `action_param2`=1 WHERE `entryorguid` IN(29475) AND `id` IN (3,4) AND `source_type`=0;
-- UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15069) AND `source_type`=0 AND `id`=1;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15146) AND `source_type`=0 AND `id`=3;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15281) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15401) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15405) AND `source_type`=0 AND `id` IN (0,5,12);
-- UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15416) AND `source_type`=0 AND `id` IN (4);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15417) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15418) AND `source_type`=0 AND `id` IN (0,5,12);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15641) AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid`=15641 AND `source_type`=0 AND `id` IN (6,8,11);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (15970,15971) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_type`=25 WHERE `entryorguid` IN (16017) AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param3`=1000, `event_param4`=1000 WHERE `entryorguid`=16024 AND `source_type`=0 AND `id` IN (0);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (16204) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (16249) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16294) AND `source_type`=0 AND `id` IN (4,11);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16307) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16308) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16311) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16318) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16329) AND `source_type`=0 AND `id` IN (0,5);

-- ============================================================================
-- 09. fe6db0c - Rename 2017_04_27_01_world.sql to 2017_03_27_01_world.sql
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/fe6db0c
-- ============================================================================
-- 
UPDATE `smart_scripts` SET `action_type`=11, `action_param1`=54693, `action_param2`=1 WHERE `entryorguid` IN(29475) AND `id` IN (3,4) AND `source_type`=0;
-- UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15069) AND `source_type`=0 AND `id`=1;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15146) AND `source_type`=0 AND `id`=3;
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15281) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15401) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15405) AND `source_type`=0 AND `id` IN (0,5,12);
-- UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15416) AND `source_type`=0 AND `id` IN (4);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15417) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15418) AND `source_type`=0 AND `id` IN (0,5,12);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (15641) AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid`=15641 AND `source_type`=0 AND `id` IN (6,8,11);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (15970,15971) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_type`=25 WHERE `entryorguid` IN (16017) AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `event_param3`=1000, `event_param4`=1000 WHERE `entryorguid`=16024 AND `source_type`=0 AND `id` IN (0);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (16204) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_flags`=1 WHERE `entryorguid` IN (16249) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16294) AND `source_type`=0 AND `id` IN (4,11);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16307) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16308) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16311) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16318) AND `source_type`=0 AND `id` IN (0,5);
UPDATE `smart_scripts` SET `event_param3`=2000, `event_param4`=2000 WHERE `entryorguid` IN (16329) AND `source_type`=0 AND `id` IN (0,5);

-- ============================================================================
-- 10. dd147ca - DB/SAI: Restore some deleted SAI scripts
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/dd147ca
-- ============================================================================
-- 
DELETE FROM `smart_scripts` WHERE `entryorguid`=17101 AND `source_type`=0 AND `id`=2;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17215 AND `source_type`=0 AND `id` IN (2, 3, 4);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17214 AND `source_type`=0 AND `id`=1;
DELETE FROM `smart_scripts` WHERE `entryorguid`=17242 AND `source_type`=0 AND `id` IN (1, 2, 3);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17117 AND `source_type`=0 AND `id` IN (2, 3);
DELETE FROM `smart_scripts` WHERE `entryorguid`=17241 AND `source_type`=0 AND `id`=1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17101, 0, 2, 0, 20, 0, 100, 0, 9452, 0, 0, 0, 5, 24, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Diktynna - On Quest 'Red Snapper - Very Tasty!' Rewarded - Play Emote 24"),
(17215, 0, 2, 0, 38, 0, 100, 512, 1, 1, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Daedal - On Data Set 1 1- Set NPC Flags"),
(17215, 0, 3, 0, 38, 0, 100, 512, 2, 2, 0, 0, 81, 83, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Daedal - On Data Set 2 2- Set NPC Flags"),
(17215, 0, 4, 0, 20, 0, 100, 512, 9473, 2, 0, 0, 80, 1721500, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Daedal - On Quest 'An Alternative Alternative' Rewarded - Run Script"),
(17214, 0, 1, 0, 20, 0, 100, 512, 9463, 2, 0, 0, 80, 1721400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Anchorite Fateema - On Quest 'Medicinal Purposes' Rewarded - Run Script"),
(17242, 0, 1, 0, 38, 0, 100, 512, 1, 1, 0, 0, 53, 0, 1724200, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Adamant Ironheart - On Data Set 1 1- Start WP (Path 1)"),
(17242, 0, 2, 0, 38, 0, 100, 512, 2, 2, 0, 0, 53, 0, 1724201, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Archaeologist Adamant Ironheart - On Data Set 2 2- Start WP (Path 2)"),
(17242, 0, 3, 0, 40, 0, 100, 512, 1, 1724201, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 6.26573, "Archaeologist Adamant Ironheart - On Reached WP1 (Path 2) - Set Orientation"),
(17117, 0, 2, 0, 38, 0, 100, 512, 1, 1, 0, 0, 91, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Injured Night Elf Priestess - On Data Set 1 1 - Set Bytes 1"),
(17117, 0, 3, 0, 38, 0, 100, 512, 2, 2, 0, 0, 90, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Injured Night Elf Priestess - On Data Set 2 2 - Set Bytes 1"),
(17241, 0, 1, 0, 20, 0, 100, 512, 9514, 0, 0, 0, 80, 1724100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Priestess Kyleen Il'dinare - On Quest 'Rune Covered Tablet' Rewarded - Run Script");

-- ============================================================================
-- 11. d1c6432 - DB/Creature: fix regenerating health for vehicles in Wintergrasp and BGs
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/d1c6432
-- ============================================================================
UPDATE `creature_template` SET `RegenHealth`=0 WHERE `entry` IN (
/* Wintergrasp */
27881, -- Wintergrasp Catapult
28094, -- Wintergrasp Demolisher
28312, -- Wintergrasp Siege Engine
28366, -- Wintergrasp Tower Cannon
32627, -- Wintergrasp Siege Engine

/* Strand of the Ancients */
27894, 32795, -- Antipersonnel Cannon
28781, 32796, -- Battleground Demolisher

/* Isle of Conquest*/
34775, 35415, -- Demolisher
34776, 35431, -- Siege Engine
34793, 35413, -- Catapult
34802, 35419, -- Glaive Thrower
34929, 35410, -- Alliance Gunship Cannon
34935, 35427, -- Horde Gunship Cannon
34944, 35429, -- Keep Cannon
35069, 35433, -- Siege Engine
35273, 35421  -- Glaive Thrower
);

-- ============================================================================
-- 12. ef249ae - DB/Spell: fix some enchants proc chances and reduced effects for levels > 60
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/ef249ae
-- ============================================================================
UPDATE `spell_enchant_proc_data` SET `customChance`=2, `PPMChance`=0, `procEx`=0x3 WHERE `entry`=1894; -- Icy Weapon
UPDATE `spell_enchant_proc_data` SET `procEx`=0x2 WHERE `entry`=1898; -- Lifestealing
UPDATE `spell_enchant_proc_data` SET `PPMChance`=3 WHERE `entry`=1899; -- Unholy Weapon
UPDATE `spell_enchant_proc_data` SET `procEx`=0x2 WHERE `entry`=1900; -- Crusader
UPDATE `spell_enchant_proc_data` SET `procEx`=0x1 WHERE `entry`=2675; -- Battlemaster

-- Condition for source Spell condition type Level
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry`=46629 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17, 0, 46629, 0, 0, 27, 0, 74, 2, 0, 0, 0, 0, '', 'Spell Deathfrost will hit the caster of the spell if player level must be lesser than 74.');

-- ============================================================================
-- 13. cdc2560 - DB/LinkedRespawn: Fixed evade issue in Ruby Sanctum mini-bosses
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/cdc2560
-- ============================================================================
DELETE FROM `linked_respawn` WHERE `guid` IN(202794,202795,202796);

-- ============================================================================
-- 14. 6b34725 - DB/SAI: Underbog
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/6b34725
-- ============================================================================

DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=17734;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17734, 0, 0, 0, 9, 0, 100, 6, 0, 10, 10500, 20000, 11, 25778, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - On Target within 10 yards range - Cast \'Knock Away\' '),
(17734, 0, 1, 0, 0, 0, 100, 6, 7100, 7100, 12000, 16000, 11, 32065, 33, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - In Combat - Cast \'Fungal Decay\''),
(17734, 0, 2, 0, 2, 0, 100, 6, 10000, 10000, 10000, 12000, 11, 40318, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - IC - Cast \'Growth\' '),
(17734, 0, 3, 4, 2, 0, 100, 7, 0, 30, 0, 0, 11, 8599, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Between 0-30% Health - Cast \'Enrage\' (No Repeat) '),
(17734, 0, 4, 0, 61, 0, 100, 7, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Underbog Lord - Between 0-30% Health - Say Line 0 (No Repeat) (Dungeon)'); 
UPDATE `creature_template` SET `gossip_menu_id`='7520' WHERE `entry`=22938;

-- ============================================================================
-- 15. 94dcd9b - DB/Misc: Fix error in my last commit
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/94dcd9b
-- ============================================================================
UPDATE`smart_scripts` SET `event_type`=0 WHERE  `entryorguid`=17734 AND `source_type`=0 AND `id`=2 AND `link`=0;

-- ============================================================================
-- 16. 7cc78e4 - DB/Script: Fix Captain Dranarus sound range
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/7cc78e4
-- ============================================================================
-- 
UPDATE `waypoint_scripts` SET `datalong2` = 2 WHERE `id` = 14 AND `command` = 16 AND `datalong` = 9739;

-- ============================================================================
-- 17. b4b2d10 - DB/Gossip: Add broadcast gossip text for Argent Gruntling/Argent Squire
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/b4b2d10
-- ============================================================================
-- 
-- Argent Tournament Champion's Pennant gossip option texts
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=35513 WHERE `MenuId`=10317 AND `OptionIndex`=0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=35515 WHERE `MenuId`=10317 AND `OptionIndex`=1;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=35534 WHERE `MenuId`=10317 AND `OptionIndex`=2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33681, `OptionText`="Darkspear Champion's Pennant" WHERE `MenuId`=10317 AND `OptionIndex`=3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33682, `OptionText`="Forsaken Champion's Pennant" WHERE `MenuId`=10317 AND `OptionIndex`=4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33683 WHERE `MenuId`=10317 AND `OptionIndex`=5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33685 WHERE `MenuId`=10317 AND `OptionIndex`=6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33686 WHERE `MenuId`=10317 AND `OptionIndex`=7;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=35513 WHERE `MenuId`=10318 AND `OptionIndex`=0;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=35515 WHERE `MenuId`=10318 AND `OptionIndex`=1;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=35534 WHERE `MenuId`=10318 AND `OptionIndex`=2;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33675 WHERE `MenuId`=10318 AND `OptionIndex`=3;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33676 WHERE `MenuId`=10318 AND `OptionIndex`=4;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33678 WHERE `MenuId`=10318 AND `OptionIndex`=5;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33679 WHERE `MenuId`=10318 AND `OptionIndex`=6;
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=33401 WHERE `MenuId`=10318 AND `OptionIndex`=7;

-- ============================================================================
-- 18. 4501716 - DB/Spell: Egg of mortal essence should proc with HoTs
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/4501716
-- ============================================================================
UPDATE `spell_proc` SET `ProcFlags`=`ProcFlags`|0x00040000 WHERE `SpellId`=33953;

-- ============================================================================
-- 19. 44f4799 - DB/Creature: Add some Winterfin Tadpole missing spawns
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/44f4799
-- ============================================================================
-- 
UPDATE `creature` SET `MovementType`=0, `wander_distance`=0 WHERE `guid`=122602;
DELETE FROM `creature` WHERE `guid` IN (78330,78331,78332,78333,78334,78335,78336,78337,78338,78339,78340,78341,78343,78344,78345,78346,78347,78348,78349,78350,78351,78352,78353,78354,78355,78356,78357,78358,78559,78560,78561,78562,78563,78564,78694,78717,78718,78719,78797,78798,78799,78800,78801,78802,78803,78804);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(78330, 25201, 571, 0, 0, '0', 0, 0, 0, 4061.56, 6254.12, 22.0839, 0.366518, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78331, 25201, 571, 0, 0, '0', 0, 0, 0, 4180.65, 6308.74, 13.1165, -2.1293, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78332, 25201, 571, 0, 0, '0', 0, 0, 0, 4104.5, 6300.65, 23.5285, 2.47837, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78333, 25201, 571, 0, 0, '0', 0, 0, 0, 4270.82, 6400.72, 0.6071, -2.35619, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78334, 25201, 571, 0, 0, '0', 0, 0, 0, 3956.81, 6368.30, 11.289, 5.480332, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78335, 25201, 571, 0, 0, '0', 0, 0, 0, 3957.67, 6367.97, 11.289, 5.791350, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78336, 25201, 571, 0, 0, '0', 0, 0, 0, 4175.71, 6243.43, 8.2020, 5.799035, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78337, 25201, 571, 0, 0, '0', 0, 0, 0, 4176.64, 6242.94, 8.2020, 5.799035, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78338, 25201, 571, 0, 0, '0', 0, 0, 0, 4297.82, 6206.78, 0.5043, 2.017601, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78339, 25201, 571, 0, 0, '0', 0, 0, 0, 4298.33, 6205.73, 0.4871, 2.017601, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78340, 25201, 571, 0, 0, '0', 0, 0, 0, 3932.18, 6394.24, 11.314, 3.171899, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78341, 25201, 571, 0, 0, '0', 0, 0, 0, 3932.65, 6393.43, 11.259, 3.142636, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78343, 25201, 571, 0, 0, '0', 0, 0, 0, 4030.72, 6332.52, 8.9144, 5.808798, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78344, 25201, 571, 0, 0, '0', 0, 0, 0, 4031.13, 6331.81, 8.9139, 1.306896, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78345, 25201, 571, 0, 0, '0', 0, 0, 0, 4282.87, 6298.21, 0.4109, 3.798534, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78346, 25201, 571, 0, 0, '0', 0, 0, 0, 4283.54, 6297.61, 0.4076, 3.798534, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78347, 25201, 571, 0, 0, '0', 0, 0, 0, 4231.83, 6183.78, 1.0935, 1.100599, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78348, 25201, 571, 0, 0, '0', 0, 0, 0, 4231.83, 6182.69, 1.0516, 1.204271, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78349, 25201, 571, 0, 0, '0', 0, 0, 0, 4161.01, 6187.51, 9.1954, 0.661131, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78350, 25201, 571, 0, 0, '0', 0, 0, 0, 4161.59, 6187.52, 9.1962, 0.661131, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78351, 25201, 571, 0, 0, '0', 0, 0, 0, 4061.44, 6254.89, 21.996, 0.734084, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78352, 25201, 571, 0, 0, '0', 0, 0, 0, 4062.39, 6253.85, 21.996, 0.734084, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78353, 25201, 571, 0, 0, '0', 0, 0, 0, 4296.56, 6250.80, 0.2237, 5.844411, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78354, 25201, 571, 0, 0, '0', 0, 0, 0, 4296.05, 6250.52, 0.2237, 5.844411, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78355, 25201, 571, 0, 0, '0', 0, 0, 0, 3985.44, 6343.04, 7.8783, 5.061456, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78356, 25201, 571, 0, 0, '0', 0, 0, 0, 3984.80, 6343.43, 7.8614, 5.061456, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78357, 25201, 571, 0, 0, '0', 0, 0, 0, 3986.35, 6481.46, 21.904, 3.438305, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78358, 25201, 571, 0, 0, '0', 0, 0, 0, 3987.27, 6481.25, 21.812, 3.438305, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78559, 25201, 571, 0, 0, '0', 0, 0, 0, 4180.73, 6308.06, 13.098, 5.146629, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78560, 25201, 571, 0, 0, '0', 0, 0, 0, 4180.34, 6308.90, 13.098, 5.146629, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78561, 25201, 571, 0, 0, '0', 0, 0, 0, 4225.53, 6229.37, 1.2251, 4.971051, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78562, 25201, 571, 0, 0, '0', 0, 0, 0, 4225.26, 6230.38, 1.3030, 2.561448, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78563, 25201, 571, 0, 0, '0', 0, 0, 0, 3997.85, 6281.56, 8.0830, 6.248281, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78564, 25201, 571, 0, 0, '0', 0, 0, 0, 3997.26, 6282.03, 7.9745, 6.248281, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78694, 25201, 571, 0, 0, '0', 0, 0, 0, 4104.50, 6301.19, 23.492, 2.575759, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78717, 25201, 571, 0, 0, '0', 0, 0, 0, 4103.94, 6300.31, 23.268, 1.843768, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78718, 25201, 571, 0, 0, '0', 0, 0, 0, 4052.07, 6298.71, 2.6548, 3.493798, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78719, 25201, 571, 0, 0, '0', 0, 0, 0, 4051.17, 6298.75, 2.6548, 3.493798, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78797, 25201, 571, 0, 0, '0', 0, 0, 0, 3830.56, 6425.12, 21.996, 0.087266, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78798, 25201, 571, 0, 0, '0', 0, 0, 0, 3830.25, 6424.62, 21.996, 0.087266, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78799, 25201, 571, 0, 0, '0', 0, 0, 0, 4038.72, 6469.18, 22.230, 1.727880, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78800, 25201, 571, 0, 0, '0', 0, 0, 0, 4038.64, 6468.21, 22.230, 2.095446, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78801, 25201, 571, 0, 0, '0', 0, 0, 0, 3973.89, 6312.81, 7.9676, 5.198990, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78802, 25201, 571, 0, 0, '0', 0, 0, 0, 3973.92, 6313.76, 7.9676, 4.677485, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78803, 25201, 571, 0, 0, '0', 0, 0, 0, 4270.12, 6400.81, 0.4071, 4.040093, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78804, 25201, 571, 0, 0, '0', 0, 0, 0, 4270.77, 6399.90, 0.4071, 4.658987, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0);

-- ============================================================================
-- 20. 5d3ee01 - DB: Fix some DB errors
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/5d3ee01
-- ============================================================================
-- 
-- UPDATE `creature` SET `spawnMask`=1 WHERE `map` IN (450,449);
-- UPDATE `gameobject` SET `spawnMask`=1 WHERE `map` IN (450,449);
UPDATE `creature_addon` SET `auras`="" WHERE `guid`=106950;

-- ============================================================================
-- 21. d5f4f77 - Rename last 2 SQL files with correct date
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/d5f4f77
-- ============================================================================
-- 
UPDATE `creature` SET `MovementType`=0, `wander_distance`=0 WHERE `guid`=122602;
DELETE FROM `creature` WHERE `guid` IN (78330,78331,78332,78333,78334,78335,78336,78337,78338,78339,78340,78341,78343,78344,78345,78346,78347,78348,78349,78350,78351,78352,78353,78354,78355,78356,78357,78358,78559,78560,78561,78562,78563,78564,78694,78717,78718,78719,78797,78798,78799,78800,78801,78802,78803,78804);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(78330, 25201, 571, 0, 0, '0', 0, 0, 0, 4061.56, 6254.12, 22.0839, 0.366518, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78331, 25201, 571, 0, 0, '0', 0, 0, 0, 4180.65, 6308.74, 13.1165, -2.1293, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78332, 25201, 571, 0, 0, '0', 0, 0, 0, 4104.5, 6300.65, 23.5285, 2.47837, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78333, 25201, 571, 0, 0, '0', 0, 0, 0, 4270.82, 6400.72, 0.6071, -2.35619, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78334, 25201, 571, 0, 0, '0', 0, 0, 0, 3956.81, 6368.30, 11.289, 5.480332, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78335, 25201, 571, 0, 0, '0', 0, 0, 0, 3957.67, 6367.97, 11.289, 5.791350, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78336, 25201, 571, 0, 0, '0', 0, 0, 0, 4175.71, 6243.43, 8.2020, 5.799035, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78337, 25201, 571, 0, 0, '0', 0, 0, 0, 4176.64, 6242.94, 8.2020, 5.799035, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78338, 25201, 571, 0, 0, '0', 0, 0, 0, 4297.82, 6206.78, 0.5043, 2.017601, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78339, 25201, 571, 0, 0, '0', 0, 0, 0, 4298.33, 6205.73, 0.4871, 2.017601, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78340, 25201, 571, 0, 0, '0', 0, 0, 0, 3932.18, 6394.24, 11.314, 3.171899, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78341, 25201, 571, 0, 0, '0', 0, 0, 0, 3932.65, 6393.43, 11.259, 3.142636, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78343, 25201, 571, 0, 0, '0', 0, 0, 0, 4030.72, 6332.52, 8.9144, 5.808798, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78344, 25201, 571, 0, 0, '0', 0, 0, 0, 4031.13, 6331.81, 8.9139, 1.306896, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78345, 25201, 571, 0, 0, '0', 0, 0, 0, 4282.87, 6298.21, 0.4109, 3.798534, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78346, 25201, 571, 0, 0, '0', 0, 0, 0, 4283.54, 6297.61, 0.4076, 3.798534, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78347, 25201, 571, 0, 0, '0', 0, 0, 0, 4231.83, 6183.78, 1.0935, 1.100599, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78348, 25201, 571, 0, 0, '0', 0, 0, 0, 4231.83, 6182.69, 1.0516, 1.204271, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78349, 25201, 571, 0, 0, '0', 0, 0, 0, 4161.01, 6187.51, 9.1954, 0.661131, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78350, 25201, 571, 0, 0, '0', 0, 0, 0, 4161.59, 6187.52, 9.1962, 0.661131, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78351, 25201, 571, 0, 0, '0', 0, 0, 0, 4061.44, 6254.89, 21.996, 0.734084, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78352, 25201, 571, 0, 0, '0', 0, 0, 0, 4062.39, 6253.85, 21.996, 0.734084, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78353, 25201, 571, 0, 0, '0', 0, 0, 0, 4296.56, 6250.80, 0.2237, 5.844411, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78354, 25201, 571, 0, 0, '0', 0, 0, 0, 4296.05, 6250.52, 0.2237, 5.844411, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78355, 25201, 571, 0, 0, '0', 0, 0, 0, 3985.44, 6343.04, 7.8783, 5.061456, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78356, 25201, 571, 0, 0, '0', 0, 0, 0, 3984.80, 6343.43, 7.8614, 5.061456, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78357, 25201, 571, 0, 0, '0', 0, 0, 0, 3986.35, 6481.46, 21.904, 3.438305, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78358, 25201, 571, 0, 0, '0', 0, 0, 0, 3987.27, 6481.25, 21.812, 3.438305, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78559, 25201, 571, 0, 0, '0', 0, 0, 0, 4180.73, 6308.06, 13.098, 5.146629, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78560, 25201, 571, 0, 0, '0', 0, 0, 0, 4180.34, 6308.90, 13.098, 5.146629, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78561, 25201, 571, 0, 0, '0', 0, 0, 0, 4225.53, 6229.37, 1.2251, 4.971051, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78562, 25201, 571, 0, 0, '0', 0, 0, 0, 4225.26, 6230.38, 1.3030, 2.561448, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78563, 25201, 571, 0, 0, '0', 0, 0, 0, 3997.85, 6281.56, 8.0830, 6.248281, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78564, 25201, 571, 0, 0, '0', 0, 0, 0, 3997.26, 6282.03, 7.9745, 6.248281, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78694, 25201, 571, 0, 0, '0', 0, 0, 0, 4104.50, 6301.19, 23.492, 2.575759, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78717, 25201, 571, 0, 0, '0', 0, 0, 0, 4103.94, 6300.31, 23.268, 1.843768, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78718, 25201, 571, 0, 0, '0', 0, 0, 0, 4052.07, 6298.71, 2.6548, 3.493798, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78719, 25201, 571, 0, 0, '0', 0, 0, 0, 4051.17, 6298.75, 2.6548, 3.493798, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78797, 25201, 571, 0, 0, '0', 0, 0, 0, 3830.56, 6425.12, 21.996, 0.087266, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78798, 25201, 571, 0, 0, '0', 0, 0, 0, 3830.25, 6424.62, 21.996, 0.087266, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78799, 25201, 571, 0, 0, '0', 0, 0, 0, 4038.72, 6469.18, 22.230, 1.727880, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78800, 25201, 571, 0, 0, '0', 0, 0, 0, 4038.64, 6468.21, 22.230, 2.095446, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78801, 25201, 571, 0, 0, '0', 0, 0, 0, 3973.89, 6312.81, 7.9676, 5.198990, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78802, 25201, 571, 0, 0, '0', 0, 0, 0, 3973.92, 6313.76, 7.9676, 4.677485, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78803, 25201, 571, 0, 0, '0', 0, 0, 0, 4270.12, 6400.81, 0.4071, 4.040093, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0),
(78804, 25201, 571, 0, 0, '0', 0, 0, 0, 4270.77, 6399.90, 0.4071, 4.658987, 300, 0, 0, 0, 0, 0, 0, 0, 0, '', 0);
-- 
-- UPDATE `creature` SET `spawnMask`=1 WHERE `map` IN (450,449);
-- UPDATE `gameobject` SET `spawnMask`=1 WHERE `map` IN (450,449);
UPDATE `creature_addon` SET `auras`="" WHERE `guid`=106950;

-- ============================================================================
-- 22. e0069d8 - DB/Creature: Add missing Spirit Healers
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/e0069d8
-- ============================================================================
-- 
DELETE FROM `creature` WHERE `guid` IN (78807,78808,78809,79283,/*79284,*/79285,79368,79378);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(78807, 6491, 530, 0, 0, '0', 0, 0, 0, 6724.2768, -7935.263, 170.098, 5.784735, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(78808, 6491, 530, 0, 0, '0', 0, 0, 0, -1423.50, 4358.489, 241.566, 5.185481, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(78809, 6491, 530, 0, 0, '0', 0, 0, 0, -2438.868, 4665.473, 161.979, 4.648291, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79283, 6491, 571, 0, 0, '0', 0, 0, 0, 8466.29, 442.502, 596.0717, 1.601781, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
-- (79284, 6491, 1,   0, 0, '0', 0, 0, 0,   -4555.235, -3600.542, 41.486, 3.899855, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79285, 6491, 571, 0, 0, '0', 0, 0, 0, 4686.022, 52.123, 73.449, 4.463720, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79368, 6491, 571, 0, 0, '0', 0, 0, 0, 6445.856, 2062.501, 563.705, 5.488712, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(79378, 6491, 571, 0, 0, '0', 0, 0, 0, 2583.27, -5802.575, 295.615, 3.652452, 72000, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- ============================================================================
-- 23. 4b8ec79 - DB/Gossip: Add Missing gossip texts for some NPCs in Sunstrider Isle
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/4b8ec79
-- ============================================================================
-- Arcanist Ithanas
UPDATE `creature_template` SET `gossip_menu_id`= 15296 WHERE `entry`= 15296;

DELETE FROM `gossip_menu` WHERE `MenuId`= 15296;
INSERT INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (15296, 7787, 0);

-- Arcanist Helion
UPDATE `creature_template` SET `gossip_menu_id`= 15297 WHERE `entry`= 15297;

DELETE FROM `gossip_menu` WHERE `MenuId`= 15297;
INSERT INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (15297, 7786, 0);

-- Lanthan Perilon
DELETE FROM `gossip_menu` WHERE `MenuId`= 6570 AND `TextId`= 7785;
INSERT INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (6570, 7785, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 14 AND `SourceGroup`= 6570;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14, 6570, 7785, 0, 0, 8, 0, 8335, 0, 0, 1, 0, 0, '', "Gossip text requires quest 'Felendren the Banished' NOT rewarded"),
(14, 6570, 7869, 0, 0, 8, 0, 8335, 0, 0, 0, 0, 0, '', "Gossip text requires quest 'Felendren the Banished' rewarded");

-- Outrunner Alarion
DELETE FROM `gossip_menu` WHERE `MenuId`= 6573 AND `TextId`= 7788;
INSERT INTO `gossip_menu` (`MenuId`,`TextId`,`VerifiedBuild`) VALUES (6573, 7788, 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 14 AND `SourceGroup`= 6573;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14, 6573, 7788, 0, 0, 8, 0, 9705, 0, 0, 1, 0, 0, '', "Gossip text requires quest 'Package Recovery' NOT rewarded"),
(14, 6573, 7821, 0, 0, 8, 0, 9705, 0, 0, 0, 0, 0, '', "Gossip text requires quest 'Package Recovery' rewarded");

-- ============================================================================
-- 24. 69c4063 - DB: RP event for Dame Auriferous, High Executor Mavren, Advisor Valwyn and Deathstalker Maltendis
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/69c4063
-- ============================================================================
-- Tranquillien RP event
SET @AURIFEROUS :=16231;
SET @SCRIPT := 1623100;
SET @MALTENDIS :=16251;
SET @MAVREN := 16252;
SET @VALWYN := 16289;

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry` IN (@AURIFEROUS, @MAVREN, @VALWYN, @MALTENDIS);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@AURIFEROUS, @SCRIPT, @MAVREN, @VALWYN, @MALTENDIS);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@AURIFEROUS,0,  0, 0, 1, 0, 100, 0, 10000, 60000, 580000, 620000, 80, @SCRIPT, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Aureous - Out Of Combat - Run Script"),
(@SCRIPT,    9,  0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Advisor Valwyn)"),
(@SCRIPT,    9,  1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0"),
(@SCRIPT,    9,  2, 0, 0, 0, 100, 0, 60000, 70000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Face High Executor Mavren"),
(@SCRIPT,    9,  3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1"),
(@SCRIPT,    9,  4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (High Executor Mavren)"),
(@SCRIPT,    9,  5, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Deathstalker Maltendis)"),
(@SCRIPT,    9,  6, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Reset Orientation"),
(@SCRIPT,    9,  7, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (High Executor Mavren)"),
(@SCRIPT,    9,  8, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Advisor Valwyn)"),
(@SCRIPT,    9,  9, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (High Executor Mavren)"),
(@SCRIPT,    9, 10, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 2"),
(@SCRIPT,    9, 11, 0, 0, 0, 100, 0, 50000, 70000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Face High Executor Mavren"),
(@SCRIPT,    9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 3"),
(@SCRIPT,    9, 13, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (High Executor Mavren)"),
(@SCRIPT,    9, 14, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 15, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Reset Orientation"),
(@SCRIPT,    9, 16, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (High Executor Mavren)"),
(@SCRIPT,    9, 17, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Advisor Valwyn)"),
(@SCRIPT,    9, 18, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (High Executor Mavren"),
(@SCRIPT,    9, 19, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 4"),
(@SCRIPT,    9, 20, 0, 0, 0, 100, 0, 50000, 70000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Face High Executor Mavren"),
(@SCRIPT,    9, 21, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 5"),
(@SCRIPT,    9, 22, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (High Executor Mavren)"),
(@SCRIPT,    9, 23, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 0 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 24, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Reset Orientation"),
(@SCRIPT,    9, 25, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 2 (High Executor Mavren)"),
(@SCRIPT,    9, 26, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Advisor Valwyn)"),
(@SCRIPT,    9, 27, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MAVREN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (High Executor Mavren"),
(@SCRIPT,    9, 28, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 6"),
(@SCRIPT,    9, 29, 0, 0, 0, 100, 0, 150000, 190000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 30, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 1 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 31, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 1 1 (Advisor Valwyn)"),
(@SCRIPT,    9, 32, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Talk 2 (Advisor Valwyn)"),
(@SCRIPT,    9, 33, 0, 0, 0, 100, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (Deathstalker Maltendis)"),
(@SCRIPT,    9, 34, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 2 2 (Advisor Valwyn)"),
(@SCRIPT,    9, 35, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 45, 3, 3, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Dame Auriferous - On Script - Set Data 3 3 (Deathstalker Maltendis)"),
(@VALWYN,    0, 0, 0, 38, 0, 100, 0, 1, 1, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 19, @MALTENDIS, 0, 0, 0, 0, 0, 0, "Advisor Valwyn - On Data 1 1 Set - Face Deathstalker Maltendis"),
(@VALWYN,    0, 1, 0, 38, 0, 100, 0, 2, 2, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Advisor Valwyn - On Data 2 2 Set - Reset Orientation"),
(@MAVREN,    0, 0, 0, 38, 0, 100, 0, 1, 1, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 19, 16231, 0, 0, 0, 0, 0, 0, "High Executor Mavren - On Data 1 1 Set - Face Dame Auriferious"),
(@MAVREN,    0, 1, 0, 38, 0, 100, 0, 2, 2, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "High Executor Mavren - On Data 2 2 Set - Reset Orientation"),
(@MALTENDIS, 0, 0, 0, 38, 0, 100, 0, 1, 1, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 19, @VALWYN, 0, 0, 0, 0, 0, 0, "Deathstalker Maltendis - On Data 1 1 Set - Face Advisor Valwyn"),
(@MALTENDIS, 0, 1, 0, 38, 0, 100, 0, 2, 2, 1000, 1000, 5, 153, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Deathstalker Maltendis - On Data 2 2 Set - Emote Laugh"),
(@MALTENDIS, 0, 2, 0, 38, 0, 100, 0, 3, 3, 1000, 1000, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Deathstalker Maltendis - On Data 3 3 Set - Reset Orientation");

DELETE FROM `creature_text` WHERE `CreatureID` IN (@AURIFEROUS, @MAVREN, @VALWYN, @MALTENDIS);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@AURIFEROUS, 0, 0, "%s nods her head yes at what her advisor has to say.", 16, 0, 100, 273, 0, 0, 13362, 0, "Dame Auriferous"),
(@AURIFEROUS, 0, 1, "%s disagrees with whatever it is that Valwyn has whispered to her.", 16, 0, 100, 274, 0, 0, 13363, 0, "Dame Auriferous"),
(@AURIFEROUS, 0, 2, "%s seems nonplussed by whatever it is that her advisor has whispered in her ear.", 16, 0, 100, 6, 0, 0, 13365, 0, "Dame Auriferous"),
(@AURIFEROUS, 1, 0, "Executor, your direct assault approach will cost us more lives than I am comfortable with. A more nuanced strategy is called for; one that involves us reclaiming the surrounding territory, starting with the villages so as to cut off all points of reinforcement to Deatholme.", 12, 1, 100, 0, 0, 0, 12552, 0, "Dame Auriferous"),
(@AURIFEROUS, 2, 0, "I hear what you are saying, Mavren. Nevertheless, the final decision is mine. I appreciate your assistance, but the majority of the lives on the line are blood elf. I will not have those lives carelessly thrown away!", 12, 1, 100, 0, 0, 0, 12571, 0, "Dame Auriferous"),
(@AURIFEROUS, 3, 0, "How long until Forsaken reinforcements arrive? Our position here is tenuous. Your Lady promised us more soldiers. We must be able to concentrate solely on Deatholme and the Scourge!", 12, 1, 100, 0, 0, 0, 12557, 0, "Dame Auriferous"),
(@AURIFEROUS, 4, 0, "Mavren, I don't want excuses, I want results! The Farstriders aren't available and we've received all that we're going to get from Silvermoon for now. I cannot ignore the Shadowpine trolls and Zul'Aman... they're arrayed across our eastern border!", 12, 1, 100, 0, 0, 0, 12572, 0, "Dame Auriferous"),
(@AURIFEROUS, 5, 0, "No, I was right to begin with. Deatholme must come last. We must secure all of the Ghostlands first. I will not commit the forces here to a battle against Dar'khan with enemies to our flank and rear!", 12, 1, 100, 0, 0, 0, 12562, 0, "Dame Auriferous"),
(@AURIFEROUS, 6, 0, "Disagree with me all you like, High Executor. I will weigh your counsel, and then we will take the steps to free all of Quel'Thalas as I deem necessary. We shall continue this discussion anon.", 12, 1, 100, 0, 0, 0, 12573, 0, "Dame Auriferous"),
(@MAVREN,     0, 0, "With all due respect, milady, you have not fought the Scourge as I have. The Lady appointed me to assist you in defeating Dar'khan because of that, and you would do well to consider what I have to say.", 12, 1, 100, 0, 0, 0, 12553, 0, "High Executor Mavren"),
(@MAVREN,     0, 1, "I strongly disagree. Dar'khan is not going to get reinforcements because he'll be bottlenecked. Deatholme has only one way in and out. Your traitor was a fool to corner himself there, and I intend to exploit that weakness!", 12, 1, 100, 0, 0, 0, 12554, 0, "High Executor Mavren"),
(@MAVREN,     0, 2, "This is war, Dame Auriferous, and in any war lives will be lost! The only areas that we need to secure are the two ziggurats. We will turtle in and take the Tower of the Damned and its master by brute force. Then you will have your Quel'Thalas.", 12, 1, 100, 0, 0, 0, 12555, 0, "High Executor Mavren"),
(@MAVREN,     0, 3, "And if your Farstriders were here to reinforce us, I might agree. But, they are busying themselves instead with the Shadowpine trolls on your eastern border. The longer we wait for them, the stronger the Scourge will become.", 12, 1, 100, 0, 0, 0, 12556, 0, "High Executor Mavren"),
(@MAVREN,     1, 0, "I believe that you're making my argument for me, but yes it would be nice if we had more reinforcements. I would counter that it would be faster to pull the Farstriders from their senseless skirmishing with the trolls.", 12, 1, 100, 0, 0, 0, 12558, 0, "High Executor Mavren"),
(@MAVREN,     1, 1, "Dame Auriferous, we are the reinforcements. It may come to pass that The Lady will send more men in time. Better that you convince Silvermoon City to muster all of its forces and put them at our disposal here.", 12, 1, 100, 0, 0, 0, 12559, 0, "High Executor Mavren"),
(@MAVREN,     1, 2, "You are correct; we must concentrate on the Scourge. Ignore the trolls and the villages, and focus our attentions on Deatholme! With Dar'khan defeated you will find that the rest of the Scourge 'body' will fall quickly, lacking their 'head'.", 12, 1, 100, 0, 0, 0, 12560, 0, "High Executor Mavren"),
(@MAVREN,     1, 3, "Forsaken reinforcements? Undercity is stretched thin with the Scourge on all sides. No, this will be a matter largely dealt with by the blood elves. We Forsaken are here as backup and advisors.", 12, 1, 100, 0, 0, 0, 12561, 0, "High Executor Mavren"),
(@MAVREN,     2, 0, "Again I strongly disagree with your view of the strategic situation. Your plan will spread our forces too thin. It will leave us with only a small force to assault Deatholme. I cannot in good conscience execute such a strategy.", 12, 1, 100, 0, 0, 0, 12567, 0, "High Executor Mavren"),
(@MAVREN,     2, 1, "Spread throughout the Ghostlands, our forces will be of little use in an assault on Deatholme. No, milady, I am here to kill Dar'khan and that is what I intend to do!", 12, 1, 100, 0, 0, 0, 12568, 0, "High Executor Mavren"),
(@MAVREN,     2, 2, "We've been over this before. Only a focused assault upon Deatholme will meet with success. These other targets are distractions that we can ill afford. I suggest that you inform your Captain Helios that he is to leave off his campaign against the Shadowpine trolls and focus solely on the Scourge.", 12, 1, 100, 0, 0, 0, 12569, 0, "High Executor Mavren"),
(@MAVREN,     2, 3, "Perhaps we should let the matter rest for the time being until your chef has prepared your meal? You look a bit piqued if you don't mind my saying. We can resume our discussion when you are feeling more yourself.", 12, 1, 100, 0, 0, 0, 12570, 0, "High Executor Mavren"),
(@VALWYN,     0, 0, "%s whispers something in the Dame's ear.", 16, 0, 100, 0, 0, 0, 13361, 0, "Advisor Valwyn"),
(@VALWYN,     1, 0, "%s looks appalled at the Executor's tone!", 16, 0, 100, 0, 0, 0, 12574, 0, "Advisor Valwyn"),
(@VALWYN,     1, 1, "%s tries to busy herself with other matters.", 16, 0, 100, 0, 0, 0, 12575, 0, "Advisor Valwyn"),
(@VALWYN,     1, 2, "%s glares daggers in the direction of High Executor Mavren and Deathstalker Maltendis.", 16, 0, 100, 0, 0, 0, 12576, 0, "Advisor Valwyn"),
(@VALWYN,     1, 3, "%s lifts her nose and sniffs in response to the High Executor's reply.", 16, 0, 100, 0, 0, 0, 12577, 0, "Advisor Valwyn"),
(@VALWYN,     1, 4, "%s shakes her head in disbelief at what she is hearing out of the Forsaken's mouth.", 16, 0, 100, 0, 0, 0, 12578, 0, "Advisor Valwyn"),
(@VALWYN,     1, 5, "%s blanches as much of the blood drains from her face.", 16, 0, 100, 0, 0, 0, 12579, 0, "Advisor Valwyn"),
(@VALWYN,     1, 6, "%s reddens furiously at what she is hearing in response to her lady's question.", 16, 0, 100, 0, 0, 0, 12580, 0, "Advisor Valwyn"),
(@VALWYN,     1, 7, "%s concentrates on the wall opposite her, clearly ignoring the looks of the Executor and his assistant.", 16, 0, 100, 0, 0, 0, 12581, 0, "Advisor Valwyn"),
(@VALWYN,     2, 0, "%s looks disgusted at the deathstalker's flirtations.", 16, 0, 100, 274, 0, 0, 13367, 0, "Advisor Valwyn"),
(@MALTENDIS,  0, 0, "%s nods in agreement.", 16, 0, 100, 0, 0, 0, 12582, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 1, "%s opens his mouth as if to add something, and then apparently thinks the better of it.", 16, 0, 100, 0, 0, 0, 12583, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 2, "%s looks over at Advisor Valwyn with a smirk on his face.", 16, 0, 100, 0, 0, 0, 12584, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 3, "%s grins at the High Executor's words.", 16, 0, 100, 0, 0, 0, 12585, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 4, "%s appears bored with the whole discussion.", 16, 0, 100, 0, 0, 0, 12586, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 5, "%s winks slyly at Advisor Valwyn.", 16, 0, 100, 0, 0, 0, 12587, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 6, "%s fidgets with his armor, clearly uncomfortable at the tone of the discussion.", 16, 0, 100, 0, 0, 0, 12588, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  0, 7, "%s looks like he'd rather be anywhere else but here.", 16, 0, 100, 0, 0, 0, 12589, 0, "Deathstalker Maltendis"),
(@MALTENDIS,  1, 0, "%s turns to Advisor Valwyn and winks lasciviously in her direction.", 16, 0, 100, 2, 0, 0, 13366, 0, "Deathstalker Maltendis");

-- ============================================================================
-- 25. 0822f0d - DB/Creature: R-3D0
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/0822f0d
-- ============================================================================
SET @R3D0 := 21690;

UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@R3D0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@R3D0, @R3D0*100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@R3D0, 0, 0, 0, 64, 0, 100, 0, 0, 0, 0, 0, 80, 2169000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Gossip Hello - Call Actionlist"),
(@R3D0*100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Script - Remove Standstate Sleep"),
(@R3D0*100, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Script - Talk"),
(@R3D0*100, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 90, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "R-3D0 - On Gossip Hello - Set Standstate Sleep");

DELETE FROM `creature_text` WHERE `CreatureID`=@R3D0;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(@R3D0, 0, 0, "WARNING!  WARNING!  AWAY HOSTILE BEINGS!  DO NOT HEAD UP THE RIDGE TO TOSHLEY'S STATION!", 12, 0, 100, 35, 0, 0, 19311, 0, "R-3D0");

-- ============================================================================
-- 26. e728959 - DB/Creature: Hargin Mundar
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/e728959
-- ============================================================================
-- 
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=1476;
DELETE FROM `smart_scripts` WHERE `entryorguid`=1476;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1476, 0, 0, 0, 1, 0, 100, 0, 5000, 30000, 300000, 600000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Hargin Mundar - Out Of Combat - Talk"),
(1476, 0, 1, 2, 1, 0, 100, 0, 35000, 45000, 300000, 600000, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Hargin Mundar - Out Of Combat - Talk"),
(1476, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 11, 41995, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Hargin Mundar - Out Of Combat - Cast Vomit");

DELETE FROM `creature_text` WHERE `CreatureID`=1476;
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(1476, 0, 0, "Stormy seas out there.  The sea spirits must be restless....hic!", 12, 6, 100, 0, 0, 0, 318, 0, "Hargin Mundar"),
(1476, 0, 1, "I saw a Sea Giant once.  It's not something I would care to see again.  Burp!", 12, 6, 100, 0, 0, 0, 319, 0, "Hargin Mundar"),
(1476, 0, 2, "I'd go out and clear out some of those gnolls, but this leg has seen better days and I am afraid I'd just wind up dead.", 12, 6, 100, 0, 0, 0, 320, 0, "Hargin Mundar"),
(1476, 0, 3, "Watch your step out there.  Many an adventure seeker has not returned from the marsh.  hic!", 12, 6, 100, 0, 0, 0, 321, 0, "Hargin Mundar"),
(1476, 1, 0, "Huuup...Huuup...Bleeeeehh!", 12, 0, 100, 0, 0, 0, 397, 0, "Hargin Mundar");


-- ============================================================================
-- 27. 3c7818a - DB/Gossip: Apprentice Shatharia and Magister Quallestis
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/3c7818a
-- ============================================================================
-- 
DELETE FROM `gossip_menu` WHERE `MenuId`=7192 AND `TextId`=8473;
DELETE FROM `gossip_menu` WHERE `MenuId`=7194 AND `TextId`=8475;
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(7192, 8473, 0),
(7194, 8475, 0);

DELETE FROM `npc_text` WHERE `ID`=8473;
INSERT INTO `npc_text` (`ID`, `Probability0`,`BroadcastTextID0`) VALUES
(8473, 100, 12182);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (7192, 7194);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14, 7192, 8472, 0, 0, 8, 0, 9207, 0, 0, 1, 0, 0, "", "Gossip text requires quest Underlight Ore Samples NOT rewarded"),
(14, 7192, 8473, 0, 0, 8, 0, 9207, 0, 0, 0, 0, 0, "", "Gossip text requires quest Underlight Ore Samples rewarded"),
(14, 7194, 8474, 0, 0, 8, 0, 9207, 0, 0, 1, 0, 0, "", "Gossip text requires quest Underlight Ore Samples NOT rewarded"),
(14, 7194, 8475, 0, 0, 8, 0, 9207, 0, 0, 0, 0, 0, "", "Gossip text requires quest Underlight Ore Samples rewarded");

UPDATE `quest_offer_reward` SET `RewardText`="My apprentice was unable to take care of this herself?  I shall have a word with her when she returns then, gnolls or not.  Speaking of which, why didn't she return with you?$B$B<The magister sighs.>$B$BThat one is a handful, and is going to be quite a challenge to properly train.  Thank you, for bringing these samples to me.  We are hoping that we can uncover some special property from them that will help in the fight against the Scourge.$B$BPlease take this coin as a token of my appreciation." WHERE `ID`=9207;

-- ============================================================================
-- 28. d9900bc - DB/Gossip: Maddix and Alieshor
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/d9900bc
-- ============================================================================
-- 
DELETE FROM `gossip_menu` WHERE `MenuId`=8558 AND `TextId`=10722;
INSERT INTO `gossip_menu` (`MenuId`,`TextId`) VALUES
(8558,10722);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup` IN (8558,8560);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,8558,7778,0,0,5,0,932,16,0,0,0,0,'',"Show gossip text if player is Friendly with The Aldor"),
(14,8558,10722,0,0,5,0,932,16,0,1,0,0,'',"Show gossip text if player is not Friendly with The Aldor"),
(14,8560,7778,0,0,5,0,934,16,0,0,0,0,'',"Show gossip text if player is Friendly with The Scryers"),
(14,8560,10723,0,0,5,0,934,16,0,1,0,0,'',"Show gossip text if player is not Friendly with The Scryers"),
(15,8558,0,0,0,5,0,932,16,0,0,0,0,'',"Show gossip menu option if player is Friendly with The Aldor"),
(15,8560,0,0,0,5,0,934,16,0,0,0,0,'',"Show gossip menu option if player is Friendly with The Scryers");

-- ============================================================================
-- 29. 4f466b2 - DB/Creature: Caer darrow area
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/4f466b2
-- ============================================================================
-- 
SET @GUID := 131324;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID + 1 AND @GUID + 23;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `npcflag`, `MovementType`) VALUES 
(@GUID + 1, 11277, 0, 0, 0, 1093.95, -2528.63, 61.2475, 5.74213, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 2, 11277, 0, 0, 0, 1095.56, -2529.47, 61.1291, 2.37365, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 3, 11277, 0, 0, 0, 1148.08, -2559.31, 60.1493, 4.15388, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 4, 11277, 0, 0, 0, 1146.79, -2561.22, 60.1145, 0.959931, 0, 0, 0, 484, 0, 0, 0),
(@GUID + 5, 11279, 0, 0, 0, 1064.06, -2519.78, 60.2259, 3.19395, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 6, 11279, 0, 0, 0, 1056.5, -2536.54, 59.9694, 2.35619, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 7, 11279, 0, 0, 0, 1245.02, -2597.47, 90.3675, 3.52556, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 8, 11280, 0, 0, 0, 1180.07, -2536.72, 85.3681, 1.0821, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 9, 11280, 0, 0, 0, 1187.12, -2532.58, 85.3681, 2.16421, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 10, 11280, 0, 0, 0, 1208.19, -2583.32, 98.2479, 2.72271, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 11, 11282, 0, 0, 0, 1113.59, -2555.59, 59.2532, 3.50681, 0, 0, 0, 42, 0, 0, 0),
(@GUID + 12, 11283, 0, 0, 0, 1111.49, -2556.4, 59.2532, 0.365222, 0, 0, 0, 42, 0, 0, 0),
(@GUID + 13, 11316, 0, 0, 0, 1223.27, -2506.41, 72.9261, 4.10152, 0, 0, 0, 3500, 0, 0, 0),
(@GUID + 14, 11277, 0, 0, 0, 1155.4, -2383.73, 60.304, 5.43574, 300, 0, 0, 2784, 0, 0, 0),
(@GUID + 15, 11281, 0, 0, 0, 1098.49, -2523.82, 61.3707, 4.6691, 1272, 0, 0, 2371, 0, 0, 0),
(@GUID + 16, 11281, 0, 0, 0, 1031.16, -2498.27, 59.177, 4.73616, 1272, 0, 0, 2371, 0, 0, 2),
(@GUID + 17, 11281, 0, 0, 0, 1090.52, -2541.25, 59.2419, 2.70896, 1272, 0, 0, 2371, 0, 0, 2),
(@GUID + 18, 11279, 0, 0, 0, 1238.9929, -2586.8103, 90.3722, 3.695799, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 19, 11277, 0, 0, 0, 1100.1054, -2589.2932, 60.624, 0.555778, 0, 0, 0, 3632, 0, 0, 0),
(@GUID + 20, 11277, 0, 0, 0, 1127.81, -2387.71, 59.264, 1.72159, 300, 0, 0, 2784, 0, 0, 0),
(@GUID + 21, 11287, 0, 0, 0, 1081.91, -2574, 59.957, 0.301, 360, 0, 0, 1536, 0, 0, 0),
(@GUID + 22, 11277, 0, 11014, 0, 1090.52, -2541.25, 59.2419, 2.70896, 1272, 0, 0, 2784, 0, 0, 2),
(@GUID + 23, 11277, 0, 11014, 0, 1231.62939, -2558.7126, 91.04164, 4.410, 1272, 0, 0, 2784, 0, 0, 2);

SET @NPC := 131340;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 5228, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '17622');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`, `delay`) VALUES
(@PATH, 1, 1031.16, -2498.27, 59.177, 10000),
(@PATH, 2, 1034.48, -2468.77, 59.9844, 0),
(@PATH, 3, 1043.48, -2458.4, 60.4699, 0),
(@PATH, 4, 1071.23, -2443.23, 61.1634, 5000),
(@PATH, 5, 1101.41, -2409.45, 59.8655, 0),
(@PATH, 6, 1125.81, -2397.36, 59.4695, 0),
(@PATH, 7, 1183.61, -2397.16, 60.1768, 10000),
(@PATH, 8, 1126.2, -2397.42, 59.4867, 0),
(@PATH, 9, 1101.19, -2409.67, 59.8831, 0),
(@PATH, 10, 1070.91, -2443.54, 61.1405, 5000),
(@PATH, 11, 1043.16, -2458.72, 60.4674, 0),
(@PATH, 12, 1034.42, -2468.71, 59.9897, 0);

SET @NPC := 131341;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 5228, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '17622');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`, `delay`) VALUES
(@PATH, 1, 1090.52, -2541.25, 59.1419, 10000),
(@PATH, 2, 1095.36, -2543.49, 59.1418, 0),
(@PATH, 3, 1118.02, -2601.04, 59.4689, 0),
(@PATH, 4, 1132.05, -2612.48, 63.1381, 0),
(@PATH, 5, 1161.32, -2620.66, 70.9007, 0),
(@PATH, 6, 1193.38, -2629.62, 74.0911, 0),
(@PATH, 7, 1214.63, -2616.73, 83.1397, 0),
(@PATH, 8, 1221.01, -2604.11, 86.3537, 0),
(@PATH, 9, 1237.11, -2595.52, 90.1566, 10000),
(@PATH, 10, 1221.38, -2603.91, 86.4882, 0),
(@PATH, 11, 1214.67, -2616.99, 83.1357, 0),
(@PATH, 12, 1193.52, -2629.6, 74.1169, 0),
(@PATH, 13, 1161.14, -2620.61, 70.8684, 0),
(@PATH, 14, 1131.64, -2612.35, 63.038, 0),
(@PATH, 15, 1117.74, -2600.92, 59.4468, 0),
(@PATH, 16, 1095.2, -2543.02, 59.1423, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (131341);
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(131341,131341,0,0,2,0,0),
(131341,131339,9,360,2,9,19);

SET @NPC := @GUID + 23;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '17622 10848');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(@PATH, 1, 1235.24, -2562.57, 91.3431, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 2, 1236.63, -2570.77, 91.5426, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 3, 1237.19, -2580.81, 90.9381, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 4, 1238.05, -2593.67, 90.1927, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 5, 1228.63, -2599.66, 88.6386, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 6, 1220.7, -2604.7, 86.2027, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 7, 1212.85, -2601.35, 83.4549, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 8, 1201.85, -2595.01, 78.5496, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 9, 1191.01, -2590.97, 74.6417, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 10, 1180.71, -2595.16, 72.9315, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 11, 1176.2, -2606.29, 72.8323, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 12, 1168.01, -2620.18, 71.895, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 13, 1173.01, -2612.22, 72.7501, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 14, 1182.33, -2592.46, 72.9574, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 15, 1197.4, -2592.45, 76.7622, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 16, 1219.52, -2604.41, 85.8084, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 17, 1237.83, -2592.45, 90.193, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 18, 1237.96, -2574.51, 91.5436, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 19, 1233.04, -2561.64, 90.6976, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 20, 1232.37, -2553.62, 91.4351, 0, 0, 0, 0, 100, 0);

SET @NPC := 131346; 
UPDATE `creature` SET `position_x`=1127.81, `position_y`=-2387.71, `position_z`=59.264, `orientation`=1.72159 WHERE  `guid`=@NPC;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '17622 10848');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES 
(@PATH, 1, 1130.21, -2395.8, 59.6262, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 2, 1137.21, -2395.91, 59.8531, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 3, 1158.21, -2396.22, 59.8991, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 4, 1179.21, -2396.51, 60.0552, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 5, 1203.92, -2392.72, 60.0587, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 6, 1190.1, -2394.95, 60.1484, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 7, 1169.22, -2396.95, 59.9472, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 8, 1155.23, -2396.77, 59.9844, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 9, 1124.17, -2397.18, 59.405, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 10, 1099.73, -2410.8, 59.9901, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 11, 1090.4, -2420.13, 60.9123, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 12, 1072.48, -2441.64, 61.2209, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 13, 1043.13, -2458.38, 60.4831, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 14, 1035.92, -2468.81, 59.9447, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 15, 1032.07, -2486.29, 59.3631, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 16, 1024.47, -2514.34, 59.1417, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 17, 1037.54, -2519.32, 59.1867, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 18, 1063.46, -2529.89, 59.1418, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 19, 1097.75, -2544.71, 59.1428, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 20, 1102.49, -2557.88, 59.1428, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 21, 1111.76, -2584.3, 59.1743, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 22, 1123.54, -2607.25, 61.0399, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 23, 1136.36, -2612.87, 64.1442, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 24, 1163.16, -2620.89, 71.2108, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 25, 1182.45, -2627.27, 72.8355, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 26, 1196.35, -2625.69, 74.9546, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 27, 1205.57, -2623.11, 78.4216, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 28, 1218.12, -2611.44, 84.922, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 29, 1232.4, -2596.93, 89.4579, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 30, 1218.97, -2605.37, 85.534, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 31, 1207.03, -2598.07, 80.8431, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 32, 1184.18, -2591.84, 73.0826, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 33, 1180.16, -2598.08, 72.8645, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 34, 1167.55, -2620.42, 71.8289, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 35, 1148.76, -2617.4, 67.9948, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 36, 1128.96, -2610.55, 62.3378, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 37, 1114.88, -2592.68, 59.2346, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 38, 1112, -2586.3, 59.1568, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 39, 1102.92, -2559.83, 59.142, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 40, 1093.84, -2542.81, 59.1414, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 41, 1067.78, -2532.62, 59.1415, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 42, 1035.69, -2518.67, 59.1449, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 43, 1022.34, -2513.6, 59.1417, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 44, 1029.52, -2499.31, 59.1618, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 45, 1032.82, -2480.03, 59.4609, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 46, 1040.28, -2461.78, 60.4131, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 47, 1068.44, -2444.34, 60.9293, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 48, 1089.28, -2422.64, 61.0531, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 49, 1110.43, -2404.84, 59.3954, 0, 0, 0, 0, 100, 0),                                                               
(@PATH, 50, 1125.89, -2397.4, 59.473, 0, 0, 0, 0, 100, 0);

UPDATE `creature_template_addon` SET `mount` = 5228 WHERE `entry` = 11281;

DELETE FROM `creature_template_addon` WHERE `entry` IN (11282, 11283, 11287, 11279, 11286, 11316, 11280);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES 
(11282, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848'),
(11283, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848'),
(11287, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848'),
(11279, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848'),
(11286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848'),
(11316, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848'),
(11280, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '17622 10848');

UPDATE `creature_template_addon` SET `auras` = '17622 10848' WHERE `entry` = 11277;
UPDATE `creature_addon` SET `StandState`=0, `AnimTier`=0, `VisFlags`=0, `auras` = '17622 10848' WHERE `guid` = 200140;

-- Melia SAI
SET @ENTRY := 11282;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,53,1,11282,1,0,0,0,1,0,0,0,0,0,0,0,"Melia - On Reset - Start Waypoint"),
(@ENTRY,0,1,0,40,0,100,0,5,11282,0,0,80,@ENTRY*100+00,2,0,0,0,0,1,0,0,0,0,0,0,0,"Melia - On Waypoint 5 Reached - Run Script");

-- Actionlist SAI
SET @ENTRY := 1128200;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,9,0,0,0,0,100,0,0,0,0,0,54,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Melia - On Script - Pause Waypoint"),
(@ENTRY,9,1,0,0,0,100,0,6000,6000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.495,"Melia - On Script - Set Orientation 3.495"),
(@ENTRY,9,2,0,0,0,100,0,3000,3000,0,0,1,0,2000,0,0,0,0,1,0,0,0,0,0,0,0,"Melia - On Script - Say Line 0"),
(@ENTRY,9,3,0,0,0,100,0,5000,5000,0,0,1,0,2000,0,0,0,0,19,11283,100,0,0,0,0,0,"Melia - On Script - Say Line 0"),
(@ENTRY,9,4,0,0,0,100,0,2000,2000,0,0,1,1,2000,0,0,0,0,1,0,0,0,0,0,0,0,"Melia - On Script - Say Line 1"),
(@ENTRY,9,5,0,0,0,100,0,14000,14000,0,0,1,2,2000,0,0,0,0,1,0,0,0,0,0,0,0,"Melia - On Script - Say Line 2"),
(@ENTRY,9,6,0,0,0,100,0,1000,1000,0,0,1,1,2000,0,0,0,0,19,11283,100,0,0,0,0,0,"Melia - On Script - Say Line 1");

-- Sammy SAI
SET @ENTRY := 11283;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,25,0,100,0,0,0,0,0,53,1,11283,1,0,0,0,1,0,0,0,0,0,0,0,"Sammy - On Reset - Start Waypoint"),
(@ENTRY,0,1,0,40,0,100,0,5,11283,0,0,54,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,"Sammy - On Waypoint 5 Reached - Pause Waypoint");

DELETE FROM `creature_text` WHERE `CreatureID` IN (11282, 11283);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`comment`) VALUES 
(11282, 0, 0, 'I win!', 12, 0, 100, 0, 2000, 0, 6808, 'Melia'),
(11282, 1, 0, 'Wanna race again? Best two out of three!', 12, 0, 100, 0, 2000, 0, 6809, 'Melia'),
(11282, 2, 0, 'Ready. Set. GO!', 12, 0, 100, 0, 2000, 0, 6806, 'Melia'),
(11283, 0, 0, 'You cheated!', 12, 0, 100, 0, 2000, 0, 6810, 'Sammy'),
(11283, 1, 0, 'HEY! No fair!', 12, 0, 100, 0, 2000, 0, 6807, 'Sammy');

DELETE FROM `waypoints` WHERE `entry` IN (11282, 11283);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(11282, 1, 1120.09, -2547.57, 59.2532, 'Melia'),
(11282, 2, 1111.05, -2537.9, 59.2532, 'Melia'),
(11282, 3, 1100.43, -2547.73, 59.2532, 'Melia'),
(11282, 4, 1109.6, -2558.2, 59.2532, 'Melia'),
(11282, 5, 1113.59, -2555.59, 59.2532, 'Melia'),
(11282, 6, 1113.59, -2555.59, 59.2532, 'Melia'),
(11283, 1, 1120.72, -2548.21, 59.2532, 'Sammy'),
(11283, 2, 1110.95, -2538.51, 59.2532, 'Sammy'),
(11283, 3, 1100.73, -2547.23, 59.2532, 'Sammy'),
(11283, 4, 1109.56, -2557.59, 59.2532, 'Sammy'),
(11283, 5, 1111.49, -2556.4, 59.2532, 'Sammy'),
(11283, 6, 1111.49, -2556.4, 59.2532, 'Sammy');

-- ============================================================================
-- 30. 0f996a7 - DB: Some Pathing on Coldarra area
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/0f996a7
-- ============================================================================
-- 
SET @CGUID:= 100865;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+13;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 25719, 571, 0, 0, '0', 0, 0, 0,  3746.502, 6604.442, 169.675, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+1, 25718, 571, 0, 0, '0', 0, 0, 0,  3746.502, 6604.442, 169.675, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+2, 25719, 571, 0, 0, '0', 0, 0, 0,  3853.462, 6582.238, 167.075, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+3, 25718, 571, 0, 0, '0', 0, 0, 0,  3853.462, 6582.238, 167.075, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+4, 25719, 571, 0, 0, '0', 0, 0, 0,  3776.172, 6673.002, 151.503, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+5, 25718, 571, 0, 0, '0', 0, 0, 0,  3776.172, 6673.002, 151.503, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+6, 25713, 571, 0, 0, '0', 0, 0, 0,  3776.486, 7118.085, 165.538, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+7, 25713, 571, 0, 0, '0', 0, 0, 0,  3800.425, 7227.171, 163.598, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+8, 25707, 571, 0, 0, '0', 0, 0, 0,  3710.079, 7142.518, 160.422, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+9, 25721, 571, 0, 0, '0', 0, 0, 0,  3899.659, 6885.204, 128.814, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+10, 25721, 571, 0, 0, '0', 0, 0, 0, 3899.659, 6885.204, 139.779, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+11, 25721, 571, 0, 0, '0', 0, 0, 0, 3947.159, 6927.227, 139.775, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+12, 25721, 571, 0, 0, '0', 0, 0, 0, 3973.956, 6999.285, 139.779, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420),
(@CGUID+13, 25721, 571, 0, 0, '0', 0, 0, 0, 3844.386, 6884.535, 139.779, 3.787364, 300, 0, 0, 0, 0, 0, 0, 0, 0, 23420);

DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+13; 
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), 
(@CGUID+1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '50637'), 
(@CGUID+2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), 
(@CGUID+3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '50637'), 
(@CGUID+4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''),
(@CGUID+5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '50637'),
(@CGUID+6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), 
(@CGUID+7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), 
(@CGUID+8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), 
(@CGUID+9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), 
(@CGUID+10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''),
(@CGUID+11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''),
(@CGUID+12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''),
(@CGUID+13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');

UPDATE `creature` SET `position_x` = 3791.703 , `position_y` = 6564.170 , `position_z` = 170.505 WHERE `guid` = 122548; 
UPDATE `creature` SET `position_x` = 3958.501 , `position_y` = 6647.100 , `position_z` = 169.00 WHERE `guid` = 122549; 
UPDATE `creature` SET `position_x` = 4056.562 , `position_y` = 6855.353 , `position_z` = 165.638 WHERE `guid` = 122827; 
UPDATE `creature` SET `position_x` = 4128.494 , `position_y` = 6852.705 , `position_z` = 174.583 WHERE `guid` = 122737; 
UPDATE `creature` SET `position_x` = 4165.607 , `position_y` = 7021.470 , `position_z` = 166.323 WHERE `guid` = 122654; 
UPDATE `creature` SET `position_x` = 4009.485 , `position_y` = 7183.581 , `position_z` = 173.116 WHERE `guid` = 122824; 
UPDATE `creature` SET `position_x` = 3690.599 , `position_y` = 6963.458 , `position_z` = 156.776 WHERE `guid` = 122551; 
UPDATE `creature` SET `position_x` = 3545.916 , `position_y` = 7085.938 , `position_z` = 210.932 , `wander_distance` = 20 WHERE `guid` = 122544; 
UPDATE `creature` SET `position_x` = 3737.879 , `position_y` = 6847.578 , `position_z` = 155.801 , `wander_distance` = 15 WHERE `guid` = 122546; 
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry` = 25718; 
UPDATE `creature` SET `wander_distance` = 35 WHERE `guid` =121092; 
UPDATE `creature` SET `wander_distance` = 35 WHERE `guid` BETWEEN 121099 AND 121111; 
UPDATE `creature_template` SET `speed_run` = 5.57143 WHERE `entry` = 24770; 
UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` = 32534; 

DELETE FROM `creature` WHERE `guid` IN (122567, 122666, 122681);
DELETE FROM `creature_addon` WHERE `guid` IN (122567, 122666, 122681);
DELETE FROM `creature_formations` WHERE `leaderGUID`= 122681;
DELETE FROM `waypoint_data` WHERE `id`=1226810;

-- Pathing for Coldarra Spellbinder Entry: 25719 'TDB FORMAT' 
SET @NPC := @CGUID+0;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3746.502,`position_y`=6604.442,`position_z`=169.6752 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3746.502,6604.442,169.6752,0,0,0,0,100,0), -- 10:09:06
(@PATH,2,3728.466,6628.31,167.4991,0,0,0,0,100,0), -- 10:09:15
(@PATH,3,3740.985,6611.622,168.9539,0,0,0,0,100,0), -- 10:09:28
(@PATH,4,3757.911,6590.785,171.0088,0,0,0,0,100,0), -- 10:09:38
(@PATH,5,3768.777,6586.423,170.0623,0,0,0,0,100,0), -- 10:09:47
(@PATH,6,3778.069,6575.995,170.2128,0,0,0,0,100,0), -- 10:09:53
(@PATH,7,3775.362,6580.682,169.8052,0,0,0,0,100,0), -- 10:10:00
(@PATH,8,3763.144,6588.104,170.9489,0,0,0,0,100,0), -- 10:10:05
(@PATH,9,3746.518,6604.487,169.7612,0,0,0,0,100,0); -- 10:10:11

DELETE FROM `creature_formations` WHERE `leaderGUID`= @CGUID+0;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+0,@CGUID+0,0,0,2,0,0),
(@CGUID+0,@CGUID+1,5,0,2,0,0);
UPDATE `creature` SET `position_x`=3746.502,`position_y`=6604.442,`position_z`=169.6752 WHERE `guid`=@CGUID+1;

-- Pathing for Coldarra Spellbinder Entry: 25719 'TDB FORMAT' 
SET @NPC := @CGUID+2;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3853.462,`position_y`=6582.238,`position_z`=167.0757 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3853.462,6582.238,167.0757,0,0,0,0,100,0), -- 10:11:07
(@PATH,2,3865.841,6600.766,165.5853,0,0,0,0,100,0), -- 10:11:18
(@PATH,3,3876.406,6620.453,165.4134,0,0,0,0,100,0), -- 10:11:27
(@PATH,4,3891.789,6642.364,166.4661,0,0,0,0,100,0), -- 10:11:39
(@PATH,5,3882.477,6631.198,166.0065,0,0,0,0,100,0), -- 10:11:50
(@PATH,6,3874.904,6617.864,165.4072,0,0,0,0,100,0), -- 10:11:59
(@PATH,7,3853.442,6582.185,167.0698,0,0,0,0,100,0); -- 10:12:11

DELETE FROM `creature_formations` WHERE `leaderGUID`= @CGUID+2;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+2,@CGUID+2,0,0,2,0,0),
(@CGUID+2,@CGUID+3,5,0,2,0,0);
UPDATE `creature` SET `position_x`=3853.462,`position_y`=6582.238,`position_z`=167.0757 WHERE `guid`=@CGUID+3;

-- Pathing for Coldarra Spellbinder Entry: 25719 'TDB FORMAT' 
SET @NPC := 122682;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3795.907,`position_y`=6607.033,`position_z`=161.6475 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3795.907,6607.033,161.6475,0,0,0,0,100,0), -- 10:09:55
(@PATH,2,3801.907,6572.36,168.6988,0,0,0,0,100,0), -- 10:10:12
(@PATH,3,3786.648,6536.464,175.4959,0,0,0,0,100,0), -- 10:10:27
(@PATH,4,3786.225,6515.275,178.2393,0,0,0,0,100,0), -- 10:10:42
(@PATH,5,3786.004,6533.51,176.1741,0,0,0,0,100,0), -- 10:10:52
(@PATH,6,3802.146,6569.362,169.4081,0,0,0,0,100,0), -- 10:10:59
(@PATH,7,3795.78,6607.015,161.4402,0,0,0,0,100,0); -- 10:11:15

DELETE FROM `creature_formations` WHERE `leaderGUID`= 122682;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(122682,122682,0,0,2,0,0),
(122682,122667,5,0,2,0,0);
UPDATE `creature` SET `position_x`=3853.462,`position_y`=6582.238,`position_z`=167.0757 WHERE `guid`=122667;

-- Pathing for Coldarra Spellbinder Entry: 25719 'TDB FORMAT' 
SET @NPC := @CGUID+4;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3776.172,`position_y`=6673.002,`position_z`=151.5036 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3776.172,6673.002,151.5036,0,0,0,0,100,0), -- 10:09:07
(@PATH,2,3784.46,6665.239,151.547,0,0,0,0,100,0), -- 10:09:12
(@PATH,3,3792.497,6660.205,151.600,0,0,0,0,100,0), -- 10:09:12
(@PATH,4,3784.46,6665.239,151.547,0,0,0,0,100,0), -- 10:09:12
(@PATH,5,3776.189,6673.356,151.5305,0,0,0,0,100,0), -- 10:09:24
(@PATH,6,3776.414,6686.501,150.9531,0,0,0,0,100,0), -- 10:09:29
(@PATH,7,3784.757,6700.908,150.913,0,0,0,0,100,0), -- 10:09:36
(@PATH,8,3776.298,6686.267,151.0565,0,0,0,0,100,0), -- 10:09:41
(@PATH,9,3776.17,6673.051,151.5327,0,0,0,0,100,0); -- 10:09:47

DELETE FROM `creature_formations` WHERE `leaderGUID`= @CGUID+4;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@CGUID+4,@CGUID+4,0,0,2,0,0),
(@CGUID+4,@CGUID+5,5,0,2,0,0);
UPDATE `creature` SET `position_x`=3776.172,`position_y`=6673.002,`position_z`=151.5036 WHERE `guid`=@CGUID+5;

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122564;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3835.835,`position_y`=6564.987,`position_z`=169.2873 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3835.835,6564.987,169.2873,0,0,0,0,100,0), -- 10:10:49
(@PATH,2,3865.19,6586.372,167.1716,0,0,0,0,100,0), -- 10:10:59
(@PATH,3,3880.876,6574.423,169.4702,0,0,0,0,100,0), -- 10:11:14
(@PATH,4,3870.494,6547.783,173.7017,0,0,0,0,100,0), -- 10:11:23
(@PATH,5,3858.838,6527.854,176.9228,0,0,0,0,100,0), -- 10:11:35
(@PATH,6,3835.596,6539.546,173.554,0,0,0,0,100,0), -- 10:11:46
(@PATH,7,3835.835,6564.987,169.2873,0,0,0,0,100,0); -- 10:10:49

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122566;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=4011.055,`position_y`=6732.877,`position_z`=160.3647 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4011.055,6732.877,160.3647,0,0,0,0,100,0), -- 11:00:47
(@PATH,2,3988.562,6729.594,157.1546,0,0,0,0,100,0), -- 11:00:58
(@PATH,3,3947.162,6749.381,152.4034,0,0,0,0,100,0), -- 11:01:07
(@PATH,4,3952.662,6772.721,153.4604,0,0,0,0,100,0), -- 11:01:24
(@PATH,5,3973.193,6814.381,158.2204,0,0,0,0,100,0), -- 11:01:35
(@PATH,6,3993.947,6794.005,160.8671,0,0,0,0,100,0), -- 11:01:53
(@PATH,7,4015.606,6759.979,163.3595,0,0,0,0,100,0), -- 11:02:06
(@PATH,8,4011.093,6732.818,160.366,0,0,0,0,100,0); -- 11:02:28

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122563;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=4170.233,`position_y`=7033.129,`position_z`=168.403 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4170.233,7033.129,168.403,0,0,0,0,100,0), -- 11:03:03
(@PATH,2,4150.032,7039.117,166.215,0,0,0,0,100,0), -- 11:03:09
(@PATH,3,4143.993,7041.999,165.5633,0,0,0,0,100,0), -- 11:03:20
(@PATH,4,4143.929,7041.769,165.4963,0,0,0,0,100,0), -- 11:03:28
(@PATH,5,4166.755,7032.029,167.6483,0,0,0,0,100,0), -- 11:03:35
(@PATH,6,4179.019,7036.918,169.7405,0,0,0,0,100,0), -- 11:03:45
(@PATH,7,4203.13,7044.137,175.2166,0,0,0,0,100,0), -- 11:03:51
(@PATH,8,4183.847,7038.913,170.8574,0,0,0,0,100,0), -- 11:04:03
(@PATH,9,4170.236,7033.129,168.4034,0,0,0,0,100,0); -- 11:04:11

-- Pathing for Coldarra Scalesworn Entry: 25717 'TDB FORMAT' 
SET @NPC := 122650;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=4110.18,`position_y`=6946.943,`position_z`=163.6098 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4110.18,6946.943,163.6098,0,0,0,0,100,0), -- 11:02:36
(@PATH,2,4103.704,6947.318,163.2632,0,0,0,0,100,0), -- 11:02:43
(@PATH,3,4103.726,6946.983,163.1357,0,0,0,0,100,0), -- 11:02:52
(@PATH,4,4115.845,6946.851,163.8068,0,0,0,0,100,0), -- 11:02:59
(@PATH,5,4119.202,6946.812,164.0883,0,0,0,0,100,0), -- 11:03:05
(@PATH,6,4135.35,6952.008,165.1999,0,0,0,0,100,0), -- 11:03:11
(@PATH,7,4133.528,6951.487,164.7321,0,0,0,0,100,0), -- 11:03:18
(@PATH,8,4129.267,6950.042,164.7286,0,0,0,0,100,0), -- 11:03:23
(@PATH,9,4110.18,6946.943,163.6098,0,0,0,0,100,0); -- 11:02:36

-- Pathing for Coldarra Scalesworn Entry: 25717 'TDB FORMAT' 
SET @NPC := 122653;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=4177.346,`position_y`=6999.94,`position_z`=167.1795 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4177.346,6999.94,167.1795,0,0,0,0,100,0), -- 11:02:53
(@PATH,2,4178.359,7003.933,167.159,0,0,0,0,100,0), -- 11:03:05
(@PATH,3,4179.334,6983.605,167.3742,0,0,0,0,100,0), -- 11:03:12
(@PATH,4,4180.535,6960.606,169.7544,0,0,0,0,100,0), -- 11:03:23
(@PATH,5,4171.201,6939.539,171.0945,0,0,0,0,100,0), -- 11:03:34
(@PATH,6,4173.018,6943.02,170.7052,0,0,0,0,100,0), -- 11:03:46
(@PATH,7,4182.021,6975.294,168.3171,0,0,0,0,100,0), -- 11:03:56
(@PATH,8,4177.346,6999.94,167.1795,0,0,0,0,100,0); -- 11:02:53

-- Pathing for Blue Drakonid Supplicant Entry: 25713 'TDB FORMAT' 
SET @NPC := @CGUID+6;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3776.486,`position_y`=7118.085,`position_z`=165.5381 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3776.486,7118.085,165.5381,0,0,0,0,100,0), -- 11:31:16
(@PATH,2,3777.939,7118.563,165.6976,0,0,0,0,100,0), -- 11:31:18
(@PATH,3,3777.769,7118.291,165.5747,0,0,0,0,100,0), -- 11:31:24
(@PATH,4,3772.185,7117.834,164.6136,0,0,0,0,100,0), -- 11:31:26
(@PATH,5,3756.582,7117.771,167.8193,0,0,0,0,100,0), -- 11:31:29
(@PATH,6,3748.333,7119.222,162.9769,0,0,0,0,100,0), -- 11:31:35
(@PATH,7,3737.513,7121.027,162.1733,0,0,0,0,100,0), -- 11:31:40
(@PATH,8,3725.984,7124.862,161.4078,0,0,0,0,100,0), -- 11:31:45
(@PATH,9,3732.13,7121.827,161.6777,0,0,0,0,100,0), -- 11:31:51
(@PATH,10,3739.073,7120.887,162.5571,0,0,0,0,100,0), -- 11:31:54
(@PATH,11,3754.043,7118.356,166.37,0,0,0,0,100,0), -- 11:31:59
(@PATH,12,3766.063,7117.793,165.3616,0,0,0,0,100,0), -- 11:32:03
(@PATH,13,3776.254,7118.123,165.5038,0,0,0,0,100,0); -- 11:32:10

-- Pathing for Blue Drakonid Supplicant Entry: 25713 'TDB FORMAT' 
SET @NPC := @CGUID+7;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3800.425,`position_y`=7227.171,`position_z`=163.5981 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3800.425,7227.171,163.5981,0,0,0,0,100,0), -- 11:30:54
(@PATH,2,3810.142,7206.111,161.8623,0,0,0,0,100,0), -- 11:30:59
(@PATH,3,3804.592,7221.301,163.6667,0,0,0,0,100,0), -- 11:31:09
(@PATH,4,3796.86,7231.097,163.0284,0,0,0,0,100,0), -- 11:31:15
(@PATH,5,3777.21,7239.271,160.0223,0,0,0,0,100,0), -- 11:31:20
(@PATH,6,3770.141,7240.695,159.4914,0,0,0,0,100,0), -- 11:31:28
(@PATH,7,3776.136,7239.694,159.5423,0,0,0,0,100,0), -- 11:31:36
(@PATH,8,3793.909,7233.141,162.8602,0,0,0,0,100,0), -- 11:31:42
(@PATH,9,3800.39,7227.242,163.4349,0,0,0,0,100,0); -- 11:31:50

-- Pathing for Magic-bound Ancient Entry: 25707 'TDB FORMAT' 
SET @NPC := @CGUID+8;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3710.079,`position_y`=7142.518,`position_z`=160.4226 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3710.079,7142.518,160.4226,0,0,0,0,100,0), -- 11:31:41
(@PATH,2,3686.689,7155.103,160.3858,0,0,0,0,100,0), -- 11:32:01
(@PATH,3,3710.107,7142.603,160.6128,0,0,0,0,100,0), -- 11:32:13
(@PATH,4,3684.977,7134.014,160.5279,0,0,0,0,100,0), -- 11:32:20
(@PATH,5,3670.651,7109.532,160.3714,0,0,0,0,100,0), -- 11:33:46
(@PATH,6,3675.45,7074.923,159.6847,0,0,0,0,100,0), -- 11:33:50
(@PATH,7,3671.232,7082.916,160.2348,0,0,0,0,100,0), -- 11:34:00
(@PATH,8,3664.486,7095.002,160.777,0,0,0,0,100,0), -- 11:34:07
(@PATH,9,3671.143,7109.756,160.2934,0,0,0,0,100,0), -- 11:34:12
(@PATH,10,3685.304,7134.208,160.3568,0,0,0,0,100,0), -- 11:34:18
(@PATH,11,3710.079,7142.518,160.4226,0,0,0,0,100,0); -- 11:31:41

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122557;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3613.729,`position_y`=7243.817,`position_z`=220.5891 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3613.729,7243.817,220.5891,0,0,0,0,100,0), -- 11:39:14
(@PATH,2,3606.35,7267.252,225.9267,0,0,0,0,100,0), -- 11:39:28
(@PATH,3,3597.403,7303.142,237.27,0,0,0,0,100,0), -- 11:39:38
(@PATH,4,3623.762,7318.709,229.6163,0,0,0,0,100,0), -- 11:39:53
(@PATH,5,3624.336,7287.603,221.3449,0,0,0,0,100,0), -- 11:40:07
(@PATH,6,3624.804,7317.062,228.2999,0,0,0,0,100,0), -- 11:40:24
(@PATH,7,3597.886,7306.813,237.9965,0,0,0,0,100,0), -- 11:40:38
(@PATH,8,3604.609,7272.363,227.2627,0,0,0,0,100,0), -- 11:40:52
(@PATH,9,3612.816,7250.049,221.6292,0,0,0,0,100,0), -- 11:41:06
(@PATH,10,3613.881,7218.981,220.517,0,0,0,0,100,0), -- 11:41:17
(@PATH,11,3613.729,7243.817,220.5891,0,0,0,0,100,0); -- 11:41:33

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122558;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3517.92,`position_y`=7212.637,`position_z`=236.2428 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3517.92,7212.637,236.2428,0,0,0,0,100,0), -- 11:35:05
(@PATH,2,3550.075,7207.158,227.5906,0,0,0,0,100,0), -- 11:35:23
(@PATH,3,3592.844,7188.292,223.4674,0,0,0,0,100,0), -- 11:35:39
(@PATH,4,3587.187,7147.094,220.9413,0,0,0,0,100,0), -- 11:35:57
(@PATH,5,3586.441,7120.506,214.5045,0,0,0,0,100,0), -- 11:36:14
(@PATH,6,3581.853,7110.294,213.1641,0,0,0,0,100,0), -- 11:36:24
(@PATH,7,3577.837,7101.881,212.4084,0,0,0,0,100,0), -- 11:36:32
(@PATH,8,3564.537,7091.157,212.0578,0,0,0,0,100,0), -- 11:36:39
(@PATH,9,3517.627,7113.079,213.7343,0,0,0,0,100,0), -- 11:36:56
(@PATH,10,3508.483,7146.259,217.3716,0,0,0,0,100,0), -- 11:37:07
(@PATH,11,3513.477,7184.227,226.257,0,0,0,0,100,0), -- 11:37:21
(@PATH,12,3507.745,7149.502,218.1569,0,0,0,0,100,0), -- 11:37:36
(@PATH,13,3514.594,7125.146,214.8003,0,0,0,0,100,0), -- 11:37:50
(@PATH,14,3520.546,7095.021,212.3433,0,0,0,0,100,0), -- 11:38:03
(@PATH,15,3520.975,7092.51,211.883,0,0,0,0,100,0), -- 11:38:14
(@PATH,16,3564.593,7091.29,212.0666,0,0,0,0,100,0), -- 11:38:31
(@PATH,17,3585.45,7118.269,213.5838,0,0,0,0,100,0), -- 11:38:38
(@PATH,18,3586.194,7142.931,219.9543,0,0,0,0,100,0), -- 11:38:47
(@PATH,19,3590.48,7164.959,223.1869,0,0,0,0,100,0), -- 11:38:57
(@PATH,20,3558.002,7205.05,226.8047,0,0,0,0,100,0), -- 11:39:14
(@PATH,21,3517.836,7212.686,236.2242,0,0,0,0,100,0); -- 11:39:31

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122559;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3687.762,`position_y`=7297.271,`position_z`=216.3398 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3687.762,7297.271,216.3398,0,0,0,0,100,0), -- 11:59:27
(@PATH,2,3707.212,7307.455,212.5712,0,0,0,0,100,0), -- 11:59:42
(@PATH,3,3722.934,7317.455,210.9211,0,0,0,0,100,0), -- 11:59:54
(@PATH,4,3745.952,7321.007,208.1814,0,0,0,0,100,0), -- 12:00:01
(@PATH,5,3773.425,7337.966,202.0872,0,0,0,0,100,0), -- 12:00:09
(@PATH,6,3803.516,7357.45,195.994,0,0,0,0,100,0), -- 12:00:23
(@PATH,7,3832.716,7372.932,194.2845,0,0,0,0,100,0), -- 12:00:38
(@PATH,8,3869.961,7381.905,190.084,0,0,0,0,100,0), -- 12:00:51
(@PATH,9,3872.366,7356.501,185.054,0,0,0,0,100,0), -- 12:01:07
(@PATH,10,3857.737,7331.208,182.6498,0,0,0,0,100,0), -- 12:01:20
(@PATH,11,3844.623,7305.171,179.0436,0,0,0,0,100,0), -- 12:01:33
(@PATH,12,3844.439,7290.313,176.6929,0,0,0,0,100,0), -- 12:01:42
(@PATH,13,3855.4,7274.202,177.718,0,0,0,0,100,0), -- 12:01:48
(@PATH,14,3886.856,7257.011,177.3157,0,0,0,0,100,0), -- 12:02:12
(@PATH,15,3868.667,7259.01,177.2133,0,0,0,0,100,0), -- 12:03:01
(@PATH,16,3853.885,7253.435,175.0069,0,0,0,0,100,0), -- 12:03:01
(@PATH,17,3844.439,7290.313,176.6929,0,0,0,0,100,0), -- 12:01:42
(@PATH,18,3872.366,7356.501,185.054,0,0,0,0,100,0), -- 12:01:07
(@PATH,19,3869.961,7381.905,190.084,0,0,0,0,100,0), -- 12:00:51
(@PATH,20,3803.516,7357.45,195.994,0,0,0,0,100,0), -- 12:00:23
(@PATH,21,3745.952,7321.007,208.1814,0,0,0,0,100,0), -- 12:00:01
(@PATH,22,3722.934,7317.455,210.9211,0,0,0,0,100,0), -- 11:59:54
(@PATH,23,3687.762,7297.271,216.3398,0,0,0,0,100,0); -- 11:59:27

-- Pathing for Glacial Ancient Entry: 25709 'TDB FORMAT' 
SET @NPC := 122565;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3708.99,`position_y`=6800.135,`position_z`=161.5988 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3708.99,6800.135,161.5988,0,0,0,0,100,0), -- 12:12:58
(@PATH,2,3692.747,6804.992,164.3114,0,0,0,0,100,0), -- 12:13:11
(@PATH,3,3639.456,6825.105,165.9832,0,0,0,0,100,0), -- 12:13:24
(@PATH,4,3665.913,6795.765,168.4959,0,0,0,0,100,0), -- 12:13:41
(@PATH,5,3640.409,6822.443,166.3176,0,0,0,0,100,0), -- 12:14:00
(@PATH,6,3671.205,6812.824,163.8588,0,0,0,0,100,0), -- 12:14:17
(@PATH,7,3706.647,6800.021,162.3539,0,0,0,0,100,0), -- 12:14:34
(@PATH,8,3735.945,6812.461,155.727,0,0,0,0,100,0), -- 12:14:47
(@PATH,9,3770.794,6815.737,150.5865,0,0,0,0,100,0), -- 12:15:00
(@PATH,10,3782.188,6807.51,151.3537,0,0,0,0,100,0), -- 12:15:17
(@PATH,11,3781.339,6813.935,150.541,0,0,0,0,100,0), -- 12:15:31
(@PATH,12,3738.144,6812.984,155.2458,0,0,0,0,100,0), -- 12:15:41
(@PATH,13,3709.039,6800.329,161.4585,0,0,0,0,100,0); -- 12:15:59

SET @NPC := 122690;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3844.386,`position_y`=6884.535,`position_z`=116.977 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3844.386,6884.535,116.977,0,0,0,0,100,0), -- 12:13:11
(@PATH,2,3899.659,6885.204,116.977,0,0,0,0,100,0);

SET @NPC := 122691;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3899.659,`position_y`=6885.204,`position_z`=116.977 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3899.659,6885.204,116.977,0,0,0,0,100,0), -- 12:13:24
(@PATH,2,3947.159,6927.227,116.977,0,0,0,0,100,0);

SET @NPC := 122692;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3947.159,`position_y`=6927.227,`position_z`=116.977 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3947.159,6927.227,116.977,0,0,0,0,100,0), -- 12:13:41
(@PATH,2,3973.956,6999.285,116.977,0,0,0,0,100,0);

SET @NPC := 122693;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3973.956,`position_y`=6999.285,`position_z`=116.977 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3973.956,6999.285,116.977,0,0,0,0,100,0), -- 12:14:00
(@PATH,2,3954.742,7044.256,116.977,0,0,0,0,100,0);

SET @NPC := 122694;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3954.742,`position_y`=7044.256,`position_z`=116.977 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3954.742,7044.256,116.977,0,0,0,0,100,0), -- 12:14:17
(@PATH,2,3849.460,7077.785,116.977,0,0,0,0,100,0);

SET @NPC := 122696;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3849.460,`position_y`=7077.785,`position_z`=116.977 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3849.460,7077.785,116.977,0,0,0,0,100,0), -- 12:14:34
(@PATH,2,3777.356,7034.979,116.977,0,0,0,0,100,0);

SET @NPC := 122699;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3771.472,`position_y`=6971.930,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3777.356,7034.979,128.814,0,0,0,0,100,0), -- 12:14:47
(@PATH,1,3771.472,6971.930,128.814,0,0,0,0,100,0); -- 12:15:00

SET @NPC := 122701;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3777.356,`position_y`=7034.979,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3849.460,7077.785,128.814,0,0,0,0,100,0), -- 12:14:34
(@PATH,1,3777.356,7034.979,128.814,0,0,0,0,100,0); -- 12:14:47

SET @NPC := 122702;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3849.460,`position_y`=7077.785,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3954.742,7044.256,128.814,0,0,0,0,100,0), -- 12:14:17
(@PATH,1,3849.460,7077.785,128.814,0,0,0,0,100,0);

SET @NPC := 122703;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3954.742,`position_y`=7044.256,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3973.956,6999.285,128.814,0,0,0,0,100,0), -- 12:14:00
(@PATH,1,3954.742,7044.256,128.814,0,0,0,0,100,0);

SET @NPC := 122704;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3973.956,`position_y`=6999.285,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3947.159,6927.227,128.814,0,0,0,0,100,0), -- 12:13:41
(@PATH,1,3973.956,6999.285,128.814,0,0,0,0,100,0);

SET @NPC := 122705;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3947.159,`position_y`=6927.227,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3899.659,6885.204,128.814,0,0,0,0,100,0), -- 12:13:24
(@PATH,1,3947.159,6927.227,128.814,0,0,0,0,100,0);

SET @NPC := @CGUID+9;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3899.659,`position_y`=6885.204,`position_z`=128.814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,2,3844.386,6884.535,128.814,0,0,0,0,100,0), -- 12:13:11
(@PATH,1,3899.659,6885.204,128.814,0,0,0,0,100,0); -- 12:13:24

SET @NPC := @CGUID+10;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3899.659,`position_y`=6885.204,`position_z`=139.779 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3899.659,6885.204,139.779,0,0,0,0,100,0), -- 12:13:24
(@PATH,2,3947.159,6927.227,139.779,0,0,0,0,100,0);

SET @NPC := @CGUID+11;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3947.159,`position_y`=6927.227,`position_z`=139.779 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3947.159,6927.227,139.779,0,0,0,0,100,0), -- 12:13:41
(@PATH,2,3973.956,6999.285,139.779,0,0,0,0,100,0);

SET @NPC := @CGUID+12;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3973.956,`position_y`=6999.285,`position_z`=139.779 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3973.956,6999.285,139.779,0,0,0,0,100,0), -- 12:14:00
(@PATH,2,3954.742,7044.256,139.779,0,0,0,0,100,0);

SET @NPC := 122699;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3954.742,`position_y`=7044.256,`position_z`=139.779 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3954.742,7044.256,139.779,0,0,0,0,100,0), -- 12:14:17
(@PATH,2,3849.460,7077.785,139.779,0,0,0,0,100,0);


SET @NPC := @CGUID+13;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3844.386,`position_y`=6884.535,`position_z`=139.779 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3844.386,6884.535,139.779,0,0,0,0,100,0), -- 12:13:11
(@PATH,2,3899.659,6885.204,139.779,0,0,0,0,100,0);

SET @NPC := 122700;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3608.967,`position_y`=6921.947,`position_z`=171.243 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3608.967,6921.947,171.243,0,0,0,0,100,0), -- 12:12:58
(@PATH,2,3645.704,6919.833,162.704,0,0,0,0,100,0), -- 12:13:11
(@PATH,3,3708.166,6916.377,141.299,0,0,0,0,100,0), -- 12:13:24
(@PATH,4,3755.512,6942.326,128.528,0,0,0,0,100,0), -- 12:13:41
(@PATH,5,3708.166,6916.377,141.299,0,0,0,0,100,0), -- 12:13:24
(@PATH,6,3645.704,6919.833,162.704,0,0,0,0,100,0), -- 12:13:11
(@PATH,7,3608.967,6921.947,171.243,0,0,0,0,100,0);

SET @NPC := 122697;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=4101.004,`position_y`= 6768.417,`position_z`= 175.147 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4101.004,6768.417,175.147,0,0,0,0,100,0), -- 12:12:58
(@PATH,2,4044.740,6779.533,166.437,0,0,0,0,100,0), -- 12:13:11
(@PATH,3,4027.592,6806.338,164.339,0,0,0,0,100,0), -- 12:13:24
(@PATH,4,4035.885,6847.380,164.952,0,0,0,0,100,0), -- 12:13:41
(@PATH,5,4003.515,6883.456,159.719,0,0,0,0,100,0), -- 12:13:24
(@PATH,6,3984.422,6925.823,132.130,0,0,0,0,100,0), -- 12:13:11
(@PATH,7,4003.515,6883.456,159.719,0,0,0,0,100,0), -- 12:13:24
(@PATH,8,4035.885,6847.380,164.952,0,0,0,0,100,0), -- 12:13:41
(@PATH,9,4027.592,6806.338,164.339,0,0,0,0,100,0), -- 12:13:24
(@PATH,10,4044.740,6779.533,166.437,0,0,0,0,100,0), -- 12:13:11
(@PATH,11,4101.004,6768.417,175.147,0,0,0,0,100,0); -- 12:12:58

SET @NPC := 122698;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=3971.448,`position_y`= 7253.354,`position_z`= 181.999 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES (@NPC, @PATH, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3971.448,7253.354,181.999,0,0,0,0,100,0), -- 12:12:58
(@PATH,2,3947.747,7224.773,172.647,0,0,0,0,100,0), -- 12:13:11
(@PATH,3,3958.392,7169.247,166.275,0,0,0,0,100,0), -- 12:13:24
(@PATH,4,3922.217,7111.124,157.287,0,0,0,0,100,0), -- 12:13:41
(@PATH,5,3912.121,7088.232,138.103,0,0,0,0,100,0), -- 12:13:24
(@PATH,6,3922.217,7111.124,157.287,0,0,0,0,100,0), -- 12:13:41
(@PATH,7,3958.392,7169.247,166.275,0,0,0,0,100,0), -- 12:13:24
(@PATH,8,3947.747,7224.773,172.647,0,0,0,0,100,0), -- 12:13:11
(@PATH,9,3971.448,7253.354,181.999,0,0,0,0,100,0);

-- Glacial Ancient SAI
SET @ENTRY := 25709;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,5000,8000,12000,16000,11,50505,0,0,0,0,0,2,0,0,0,0,0,0,0,"Glacial Ancient - In Combat - Cast 'Frost Breath'");

-- Coldarra Scalesworn SAI
SET @ENTRY := 25717;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,3000,5000,15000,17000,11,11977,0,0,0,0,0,2,0,0,0,0,0,0,0,"Coldarra Scalesworn - In Combat - Cast 'Rend'"),
(@ENTRY,0,1,0,0,0,100,0,1000,3000,8000,12000,11,12748,0,0,0,0,0,2,0,0,0,0,0,0,0,"Coldarra Scalesworn - In Combat - Cast 'Frost Nova'");

-- Scalesworn Elite SAI
SET @ENTRY := 32534;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,0,0,100,0,0,3000,3000,8000,11,61269,0,0,0,0,0,2,0,0,0,0,0,0,0,"Scalesworn Elite - In Combat - Cast 'Ice Shard'"),
(@ENTRY,0,1,0,0,0,100,0,6000,9000,16000,22000,11,61272,0,0,0,0,0,2,0,0,0,0,0,0,0,"Scalesworn Elite - In Combat - Cast 'Arcane Surge'");

DELETE FROM `gameobject` WHERE `guid`IN(46,48,50,55,57);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
(46, 188113, 571, 0, 0, '0', 0, 4127.31, 6852.023, 174.3926, 3.717554, 0, 0, -0.9588194, 0.2840165, 120, 255, 1, 23420), -- 188113 (Area: -1)
(48, 188113, 571, 0, 0, '0', 0, 4123.374, 6881.992, 172.3801, 0.4188786, 0, 0, 0.2079115, 0.9781476, 120, 255, 1, 23420), -- 188113 (Area: -1)
(50, 188113, 571, 0, 0, '0', 0, 4095.132, 6847.428, 168.9135, 2.007128, 0, 0, 0.8433914, 0.5372996, 120, 255, 1, 23420), -- 188113 (Area: -1)
(55, 188113, 571, 0, 0, '0', 0, 3872.185, 7336.54, 181.9368, 2.495818, 0, 0, 0.9483232, 0.3173059, 120, 255, 1, 23420), -- 188113 (Area: -1)
(57, 188113, 571, 0, 0, '0', 0, 3880.16, 7309.908, 181.1171, 6.178466, 0, 0, -0.05233574, 0.9986296, 120, 255, 1, 23420); -- 188113 (Area: -1)
 

-- ============================================================================
-- 31. 432cb32 - DB/Creature: Add some missing spawns to Naxxanar area
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/432cb32
-- ============================================================================
SET @CGUID:= 146625;
DELETE FROM `creature` WHERE `id` = 25390;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+249;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 25377, 571, 0, 0, '0', 1, 0, 0, 3856.362, 3761.855, 51.49897, 1.787884, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+1, 25377, 571, 0, 0, '0', 1, 0, 0, 3848.972, 3760.094, 53.60237, 2.532431, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+2, 25377, 571, 0, 0, '0', 1, 0, 0, 3845.313, 3760.938, 55.2104, 2.888491, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+3, 25377, 571, 0, 0, '0', 1, 0, 0, 3854.785, 3778.629, 56.78143, 1.964004, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+4, 25377, 571, 0, 0, '0', 1, 0, 0, 3895.797, 3773.958, 51.84527, 5.737518, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+5, 15214, 571, 0, 0, '0', 1, 0, 0, 3889.836, 3771.971, 51.535, 1.236767, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 15214 (Area: -1)
(@CGUID+6, 25378, 571, 0, 0, '0', 1, 0, 0, 3945.438, 3731.835, 62.38454, 1.710423, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+7, 25377, 571, 0, 0, '0', 1, 0, 0, 3873.349, 3778.878, 54.86187, 0.915302, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+8, 25377, 571, 0, 0, '0', 1, 0, 0, 3937.869, 3761.81, 66.29324, 2.285362, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+9, 25377, 571, 0, 0, '0', 1, 0, 0, 3905.761, 3785.872, 56.2091, 5.008369, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+10, 25377, 571, 0, 0, '0', 1, 0, 0, 3852.035, 3777.488, 56.57757, 2.511892, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+11, 25377, 571, 0, 0, '0', 1, 0, 0, 3895.971, 3777.111, 52.89691, 5.152364, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+12, 25377, 571, 0, 0, '0', 1, 0, 0, 3859.266, 3777.747, 55.64642, 3.875577, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+13, 25377, 571, 0, 0, '0', 1, 0, 0, 3873.917, 3773.739, 53.1734, 3.546263, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+14, 25377, 571, 0, 0, '0', 1, 0, 0, 3858.755, 3773.773, 54.30145, 2.155118, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+15, 25377, 571, 0, 0, '0', 1, 0, 0, 3934.469, 3758.464, 65.99844, 0.7296588, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+16, 25377, 571, 0, 0, '0', 1, 0, 0, 3871.434, 3774.329, 52.98407, 1.029868, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+17, 25377, 571, 0, 0, '0', 1, 0, 0, 3895.806, 3782.894, 54.03167, 2.843827, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+18, 25377, 571, 0, 0, '0', 1, 0, 0, 3857.359, 3780.822, 57.45977, 6.231272, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+19, 25378, 571, 0, 0, '0', 1, 0, 0, 3887.787, 3748.568, 46.64261, 1.832596, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+20, 25377, 571, 0, 0, '0', 1, 0, 0, 3881.459, 3771.939, 52.34649, 2.209149, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+21, 25377, 571, 0, 0, '0', 1, 0, 0, 3901.681, 3773.557, 53.1372, 2.395434, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+22, 25377, 571, 0, 0, '0', 1, 0, 0, 3876.524, 3776.051, 54.03057, 1.422759, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+23, 25377, 571, 0, 0, '0', 1, 0, 0, 3853.302, 3774.513, 55.80389, 2.107602, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+24, 25377, 571, 0, 0, '0', 1, 0, 0, 3942.292, 3757.19, 65.39615, 0.939211, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+25, 25377, 571, 0, 0, '0', 1, 0, 0, 3877.188, 3770.377, 51.82452, 0.562353, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+26, 25377, 571, 0, 0, '0', 1, 0, 0, 3946.085, 3758.676, 65.89896, 3.295287, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+27, 25377, 571, 0, 0, '0', 1, 0, 0, 3901.85, 3781.824, 55.3778, 0.7305052, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+28, 25377, 571, 0, 0, '0', 1, 0, 0, 3950.509, 3760.267, 66.09, 2.847162, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+29, 15214, 571, 0, 0, '0', 1, 0, 0, 3942.177, 3756.028, 65.025, 4.628274, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 15214 (Area: -1) (Auras: )
-- (@CGUID+30, 25492, 571, 0, 0, '0', 0, 0, 0, 4023.196, 3604.876, 106.491, 1.675516, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25492 (Area: -1)
(@CGUID+31, 25377, 571, 0, 0, '0', 1, 0, 0, 3940.087, 3778.05, 67.43326, 5.391348, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+32, 25377, 571, 0, 0, '0', 1, 0, 0, 3947.441, 3774.648, 67.16287, 5.483166, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+33, 25377, 571, 0, 0, '0', 1, 0, 0, 3950.542, 3756.351, 65.14139, 1.024377, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+34, 25377, 571, 0, 0, '0', 1, 0, 0, 3951.158, 3783.321, 66.46609, 1.680158, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+35, 25377, 571, 0, 0, '0', 1, 0, 0, 3946.375, 3798.536, 69.6951, 1.496066, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+36, 25377, 571, 0, 0, '0', 1, 0, 0, 3950.66, 3779.663, 66.48564, 0.2942728, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+37, 25377, 571, 0, 0, '0', 1, 0, 0, 3953.416, 3814.574, 71.72324, 1.447305, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+38, 25378, 571, 0, 0, '0', 1, 0, 0, 3983.542, 3769.677, 62.64833, 4.859846, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+39, 25377, 571, 0, 0, '0', 1, 0, 0, 3942.997, 3797.084, 69.11807, 4.048098, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+40, 25377, 571, 0, 0, '0', 1, 0, 0, 3939.094, 3821.365, 70.90989, 4.823489, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+41, 25377, 571, 0, 0, '0', 1, 0, 0, 3943.163, 3783.04, 67.5856, 0.6302186, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+42, 25377, 571, 0, 0, '0', 1, 0, 0, 3947.942, 3807.152, 70.84385, 6.25543, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+43, 25377, 571, 0, 0, '0', 1, 0, 0, 3947.802, 3804.568, 70.63902, 4.229197, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+44, 25377, 571, 0, 0, '0', 1, 0, 0, 3955.821, 3811.656, 71.62571, 2.640486, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+45, 25377, 571, 0, 0, '0', 1, 0, 0, 3942.419, 3806.433, 70.30625, 6.006355, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+46, 25377, 571, 0, 0, '0', 1, 0, 0, 3955.7, 3781.918, 64.83658, 6.117535, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+47, 25377, 571, 0, 0, '0', 1, 0, 0, 3939.559, 3803.456, 69.71299, 3.782476, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+48, 25377, 571, 0, 0, '0', 1, 0, 0, 3938.022, 3836.511, 73.84203, 5.077127, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+49, 25377, 571, 0, 0, '0', 1, 0, 0, 3956.413, 3817.224, 72.36948, 3.131958, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+50, 25377, 571, 0, 0, '0', 1, 0, 0, 4010.828, 3739.584, 66.05321, 0.8970829, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+51, 25377, 571, 0, 0, '0', 1, 0, 0, 4008.854, 3730.729, 65.51659, 5.020262, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+52, 25377, 571, 0, 0, '0', 1, 0, 0, 4013.835, 3739.858, 66.744, 3.290065, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+53, 25377, 571, 0, 0, '0', 1, 0, 0, 4013.431, 3732.159, 67.31004, 4.268528, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+54, 25377, 571, 0, 0, '0', 1, 0, 0, 4003.856, 3737.709, 64.45518, 2.910134, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
-- (@CGUID+55, 25391, 571, 0, 0, '0', 0, 0, 0, 4024.555, 3742.407, 88.99696, 3.543018, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25391 (Area: -1) (Auras: )
(@CGUID+56, 25377, 571, 0, 0, '0', 0, 0, 0, 3985.718, 3813.569, 68.40765, 2.829013, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+57, 25377, 571, 0, 0, '0', 0, 0, 0, 4014.136, 3736.033, 67.28185, 4.049169, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+58, 25377, 571, 0, 0, '0', 0, 0, 0, 4006.304, 3819.676, 72.36139, 0.5565031, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+59, 25377, 571, 0, 0, '0', 0, 0, 0, 3983.958, 3819.676, 71.01385, 1.145607, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+60, 25377, 571, 0, 0, '0', 0, 0, 0, 4019.725, 3801.281, 66.31256, 2.917216, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+61, 25378, 571, 0, 0, '0', 0, 0, 0, 4003.135, 3791.937, 62.67893, 1.675516, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
-- (@CGUID+62, 25391, 571, 0, 0, '0', 0, 0, 0, 4014.546, 3773.259, 88.09467, 3.176499, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25391 (Area: -1) (Auras: )
(@CGUID+63, 25377, 571, 0, 0, '0', 0, 0, 0, 3979.844, 3820.275, 71.65765, 4.897894, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+64, 25377, 571, 0, 0, '0', 0, 0, 0, 3977.068, 3832.302, 76.76068, 5.369745, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+65, 25377, 571, 0, 0, '0', 0, 0, 0, 3975.965, 3811.767, 69.58331, 4.890862, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+66, 25377, 571, 0, 0, '0', 0, 0, 0, 3961.483, 3809.533, 71.12608, 1.679816, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+67, 25378, 571, 0, 0, '0', 0, 0, 0, 4031.613, 3765.301, 88.1413, 2.775074, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+68, 25377, 571, 0, 0, '0', 0, 0, 0, 3930.518, 3831.502, 70.80496, 4.922265, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+69, 25377, 571, 0, 0, '0', 0, 0, 0, 3943.751, 3825.671, 72.6898, 1.378705, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+70, 25377, 571, 0, 0, '0', 0, 0, 0, 3999.025, 3816.855, 70.74554, 0.3368048, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+71, 25377, 571, 0, 0, '0', 0, 0, 0, 3943.419, 3831.631, 74.16563, 3.242679, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+72, 25377, 571, 0, 0, '0', 0, 0, 0, 3980.091, 3835.34, 77.89709, 4.097147, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+73, 25377, 571, 0, 0, '0', 0, 0, 0, 3985.691, 3810.795, 67.0307, 5.729337, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+74, 25377, 571, 0, 0, '0', 0, 0, 0, 3961.77, 3812.996, 71.89756, 0.1600965, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+75, 25377, 571, 0, 0, '0', 0, 0, 0, 3953.116, 3839.654, 77.24921, 1.785299, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+76, 25377, 571, 0, 0, '0', 0, 0, 0, 3994.533, 3822.952, 73.17596, 0.7260628, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+77, 25377, 571, 0, 0, '0', 0, 0, 0, 3978.996, 3816.431, 70.33807, 0.5169653, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+78, 25377, 571, 0, 0, '0', 0, 0, 0, 3956.791, 3817.895, 72.57554, 2.857513, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+79, 25377, 571, 0, 0, '0', 0, 0, 0, 4007.341, 3814.753, 69.79547, 5.739625, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+80, 25377, 571, 0, 0, '0', 0, 0, 0, 4007.547, 3819.425, 72.16815, 1.637677, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+81, 25377, 571, 0, 0, '0', 0, 0, 0, 3949.229, 3843.808, 77.34271, 4.109823, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+82, 25377, 571, 0, 0, '0', 0, 0, 0, 4003.176, 3822.928, 73.94293, 4.416482, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+83, 25377, 571, 0, 0, '0', 0, 0, 0, 3973.253, 3840.189, 79.14282, 0.1356232, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
-- (@CGUID+84, 25471, 571, 0, 0, '0', 0, 0, 0, 4111.138, 3734.866, 91.84813, 3.996804, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25471 (Area: -1)  -- 
(@CGUID+85, 25377, 571, 0, 0, '0', 0, 0, 0, 3958.608, 3842.374, 77.76642, 3.547766, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+86, 25378, 571, 0, 0, '0', 0, 0, 0, 4042.49, 3745.191, 88.50867, 3.246312, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+87, 25377, 571, 0, 0, '0', 0, 0, 0, 3933.178, 3842.617, 73.65913, 0.7102271, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+88, 25377, 571, 0, 0, '0', 0, 0, 0, 3985.925, 3836.56, 78.08765, 0.3928989, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+89, 25377, 571, 0, 0, '0', 0, 0, 0, 4018.704, 3807.378, 68.41994, 3.146591, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+90, 25377, 571, 0, 0, '0', 0, 0, 0, 4024.622, 3802.451, 68.20343, 2.903348, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
-- (@CGUID+91, 25391, 571, 0, 0, '0', 0, 0, 0, 4053.731, 3790.188, 88.898, 5.358161, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25391 (Area: -1) (Auras: )
(@CGUID+92, 25377, 571, 0, 0, '0', 0, 0, 0, 4023.776, 3809.938, 69.86577, 3.449748, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+93, 25377, 571, 0, 0, '0', 0, 0, 0, 4041.068, 3812.419, 73.50181, 2.869276, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+94, 25377, 571, 0, 0, '0', 0, 0, 0, 3977.11, 3842.004, 79.86098, 0.7784538, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+95, 25377, 571, 0, 0, '0', 0, 0, 0, 4040.451, 3802.602, 70.72752, 2.495649, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+96, 25377, 571, 0, 0, '0', 0, 0, 0, 4017.696, 3822.242, 73.9433, 5.397349, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+97, 25377, 571, 0, 0, '0', 0, 0, 0, 4044.622, 3802.832, 70.57517, 0.5576683, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+98, 25377, 571, 0, 0, '0', 0, 0, 0, 4011.047, 3839.548, 76.7318, 6.244549, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+99, 25377, 571, 0, 0, '0', 0, 0, 0, 4026.381, 3805.319, 69.17072, 5.322569, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+100, 25377, 571, 0, 0, '0', 0, 0, 0, 4043.563, 3797.688, 70.98014, 5.236726, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+101, 25377, 571, 0, 0, '0', 0, 0, 0, 3993.121, 3844.239, 79.35071, 5.135974, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+102, 25377, 571, 0, 0, '0', 0, 0, 0, 4019.319, 3811.758, 70.11395, 5.55163, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+103, 25377, 571, 0, 0, '0', 0, 0, 0, 4028.581, 3822.207, 74.36981, 5.899706, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+104, 25377, 571, 0, 0, '0', 0, 0, 0, 3947.608, 3847.873, 77.20355, 2.409402, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+105, 25377, 571, 0, 0, '0', 0, 0, 0, 4026.606, 3825.278, 75.37921, 6.166935, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+106, 25377, 571, 0, 0, '0', 0, 0, 0, 4021.991, 3829.991, 76.58698, 4.33053, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+107, 25377, 571, 0, 0, '0', 0, 0, 0, 4040.658, 3797.008, 71.00822, 3.501203, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+108, 25377, 571, 0, 0, '0', 0, 0, 0, 4004.436, 3840.204, 77.43212, 1.105561, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+109, 25377, 571, 0, 0, '0', 0, 0, 0, 3956.497, 3851.48, 78.62555, 3.324586, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+110, 25377, 571, 0, 0, '0', 0, 0, 0, 4038.561, 3815.458, 74.1273, 1.256246, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+111, 25377, 571, 0, 0, '0', 0, 0, 0, 3980.532, 3839.45, 79.25122, 5.701941, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+112, 25377, 571, 0, 0, '0', 0, 0, 0, 4037.742, 3797.284, 70.75016, 3.675025, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+113, 25377, 571, 0, 0, '0', 0, 0, 0, 4024.293, 3820.985, 73.6358, 0.74111, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+114, 25377, 571, 0, 0, '0', 0, 0, 0, 3969.766, 3851.225, 80.8999, 1.407759, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+115, 25377, 571, 0, 0, '0', 0, 0, 0, 4044.113, 3798.313, 71.03507, 1.526782, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+116, 25377, 571, 0, 0, '0', 0, 0, 0, 3988.41, 3863.551, 85.09741, 1.77021, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+117, 25377, 571, 0, 0, '0', 0, 0, 0, 3980.214, 3854.178, 82.61475, 1.526452, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+118, 25377, 571, 0, 0, '0', 0, 0, 0, 4061.403, 3806.529, 73.14072, 1.009966, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+119, 25377, 571, 0, 0, '0', 0, 0, 0, 3952.42, 3855.544, 78.36176, 5.831243, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+120, 25377, 571, 0, 0, '0', 0, 0, 0, 3978.812, 3856.061, 83.19165, 1.515909, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+121, 25377, 571, 0, 0, '0', 0, 0, 0, 4041.886, 3825.319, 76.65525, 2.360835, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+122, 25378, 571, 0, 0, '0', 0, 0, 0, 4059.954, 3772.845, 88.27218, 2.076942, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+123, 25377, 571, 0, 0, '0', 0, 0, 0, 4054.301, 3809.695, 73.50803, 1.462021, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+124, 25377, 571, 0, 0, '0', 0, 0, 0, 4001.414, 3852.939, 83.30297, 0.7778957, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+125, 25377, 571, 0, 0, '0', 0, 0, 0, 4027.71, 3835.373, 77.92162, 2.965322, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+126, 25377, 571, 0, 0, '0', 0, 0, 0, 3971.56, 3854.037, 81.95898, 3.315667, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+127, 25377, 571, 0, 0, '0', 0, 0, 0, 4043.886, 3813.275, 73.8187, 5.252536, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+128, 25377, 571, 0, 0, '0', 0, 0, 0, 3992.059, 3860.479, 85.22095, 0.3067477, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+129, 25387, 571, 0, 0, '0', 0, 0, 0, 4108.792, 3628.817, 117.1614, 1.936917, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25387 (Area: -1)
(@CGUID+130, 25377, 571, 0, 0, '0', 0, 0, 0, 4040.829, 3821.539, 75.87366, 3.807508, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+131, 25377, 571, 0, 0, '0', 0, 0, 0, 3978.755, 3862.269, 84.41016, 6.079549, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+132, 25377, 571, 0, 0, '0', 0, 0, 0, 4011.224, 3842.406, 77.72607, 1.74512, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+133, 25377, 571, 0, 0, '0', 0, 0, 0, 3972.081, 3859.687, 83.02417, 6.191478, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+134, 25377, 571, 0, 0, '0', 0, 0, 0, 4055.908, 3812.092, 74.2761, 5.387706, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+135, 15214, 571, 0, 0, '0', 0, 0, 0, 4015.447, 3812.16, 69.756, 4.06342, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 15214 (Area: -1)
(@CGUID+136, 25377, 571, 0, 0, '0', 0, 0, 0, 4041.674, 3819.853, 75.61887, 1.068842, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+137, 25377, 571, 0, 0, '0', 0, 0, 0, 3994.814, 3862.187, 86.10242, 2.840913, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+138, 25377, 571, 0, 0, '0', 0, 0, 0, 4007.844, 3844.194, 78.89172, 1.35082, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+139, 25377, 571, 0, 0, '0', 0, 0, 0, 4058.096, 3808.438, 73.66172, 0.9468706, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+140, 25377, 571, 0, 0, '0', 0, 0, 0, 3995.671, 3863.357, 86.48828, 1.222019, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+141, 25377, 571, 0, 0, '0', 0, 0, 0, 3994.089, 3869.741, 86.92256, 4.403831, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+142, 25377, 571, 0, 0, '0', 0, 0, 0, 4060.221, 3813.648, 74.87791, 2.561906, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+143, 25377, 571, 0, 0, '0', 0, 0, 0, 4060.921, 3810.31, 74.20188, 0.7864025, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
(@CGUID+144, 25378, 571, 0, 0, '0', 0, 0, 0, 4084.625, 3781.453, 88.1413, 1.308997, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+145, 25391, 571, 0, 0, '0', 0, 0, 0, 4087.144, 3803.259, 88.88715, 6.178465, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25391 (Area: -1) (Auras: )
(@CGUID+146, 25377, 571, 0, 0, '0', 0, 0, 0, 3995.967, 3869.417, 87.43391, 1.641255, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: -1)
-- (@CGUID+148, 25378, 571, 0, 0, '0', 0, 0, 0, 4104.68, 3755.165, 92.74696, 5.305801, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
-- (@CGUID+149, 25391, 571, 0, 0, '0', 0, 0, 0, 4052.662, 3672.709, 89.06155, 4.991642, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25391 (Area: -1) (Auras: )
-- (@CGUID+150, 25383, 571, 0, 0, '0', 0, 0, 0, 3880.311, 3627.948, 46.88836, 2.70526, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25383 (Area: -1) (Auras: 45617 - 45617)
(@CGUID+151, 15214, 571, 0, 0, '0', 0, 0, 0, 4111.582, 3735.073, 91.764, 3.473205, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 15214 (Area: -1)
-- (@CGUID+152, 25391, 571, 0, 0, '0', 0, 0, 0, 4045.809, 3648.79, 88.94188, 3.298672, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25391 (Area: -1) (Auras: )
-- (@CGUID+154, 26076, 571, 0, 0, '0', 0, 0, 0, 4111.339, 3735.037, 91.84813, 3.577925, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 26076 (Area: -1)
(@CGUID+155, 25378, 571, 0, 0, '0', 0, 0, 0, 4073.151, 3662.264, 88.30914, 2.70526, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+156, 25393, 571, 0, 0, '0', 0, 0, 0, 4111.396, 3669.310, 88.182, 1.427202, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: -1)
(@CGUID+157, 25378, 571, 0, 0, '0', 0, 0, 0, 4061.825, 3641.445, 88.11076, 2.635447, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+158, 25393, 571, 0, 0, '0', 0, 0, 0, 4022.36, 3621.078, 100.6157, 4.967927, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: -1)
-- (@CGUID+159, 25378, 571, 0, 0, '0', 0, 0, 0, 4120.856, 3713.722, 92.74776, 1.762783, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+160, 25393, 571, 0, 0, '0', 0, 0, 0, 4145.623, 3676.927, 88.1825, 0.2252303, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: 4136)
-- (@CGUID+161, 25378, 571, 0, 0, '0', 0, 0, 0, 4127.498, 3741.052, 92.75615, 3.787364, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: 4136)
(@CGUID+162, 25472, 571, 0, 0, '0', 0, 0, 0, 4094.381, 3493.948, 152.6763, 0.7679449, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25472 (Area: 4136)
(@CGUID+163, 25393, 571, 0, 0, '0', 0, 0, 0, 4126.54, 3615.563, 88.83325, 4.462672, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: 4136)
(@CGUID+164, 25393, 571, 0, 0, '0', 0, 0, 0, 4112.138, 3573.525, 106.1573, 2.034444, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: 4125) (Auras: 33963 - 33963)
(@CGUID+165, 25393, 571, 0, 0, '0', 0, 0, 0, 3825.306, 3621.834, 46.977, 3.186528, 300, 7, 0, 1, 0, 1, 0, 0, 0, 23420),
(@CGUID+166, 25393, 571, 0, 0, '0', 0, 0, 0, 4007.476, 3587.082, 100.544, 3.186528, 300, 7, 0, 1, 0, 1, 0, 0, 0, 23420),
(@CGUID+167, 25393, 571, 0, 0, '0', 0, 0, 0, 4049.438, 3575.568, 106.517, 3.186528, 300, 7, 0, 1, 0, 1, 0, 0, 0, 23420),
(@CGUID+168, 25378, 571, 0, 0, '0', 0, 0, 0, 4067.834, 3528.134, 118.3771, 1.19083, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+169, 25378, 571, 0, 0, '0', 0, 0, 0, 4101.848, 3536.834, 109.293, 2.548181, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+170, 25378, 571, 0, 0, '0', 0, 0, 0, 4062.422, 3465.097, 109.2684, 2.635447, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: -1)
(@CGUID+171, 25378, 571, 0, 0, '0', 0, 0, 0, 4116.766, 3464.181, 108.9272, 1.073311, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: 4135)
(@CGUID+172, 25378, 571, 0, 0, '0', 0, 0, 0, 4099.074, 3478.396, 109.105, 5.759586, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: 4135)
(@CGUID+173, 25378, 571, 0, 0, '0', 0, 0, 0, 4094.816, 3451.6, 128.4207, 2.684189, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: 4135) (possible waypoints or random movement)
(@CGUID+174, 25378, 571, 0, 0, '0', 0, 0, 0, 4111.819, 3499.67, 109.1208, 5.864306, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: 4135)
(@CGUID+175, 25378, 571, 0, 0, '0', 0, 0, 0, 3900.854, 3515.069, 46.74826, 4.921828, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25378 (Area: 4125)
(@CGUID+176, 25393, 571, 0, 0, '0', 0, 0, 0, 4079.765, 3412.597, 107.1055, 5.053613, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: -1) (Auras: 33963 - 33963)
(@CGUID+177, 25393, 571, 0, 0, '0', 0, 0, 0, 3946.659, 3484.503, 99.422, 0.6282206, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: -1) (Auras: 33963 - 33963)
(@CGUID+178, 25393, 571, 0, 0, '0', 0, 0, 0, 3975.619, 3492.427, 99.16926, 2.584305, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: -1) (Auras: 33963 - 33963)
(@CGUID+179, 25393, 571, 0, 0, '0', 0, 0, 0, 3972.511, 3518.948, 99.9718, 2.297545, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: 4125) (Auras: 33963 - 33963)
(@CGUID+180, 25386, 571, 0, 0, '0', 0, 0, 0, 3860.269, 3521.542, 46.6651, 1.074683, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25393 (Area: 4125)  
(@CGUID+181, 25377, 571, 0, 0, '0', 0, 0, 0, 3911.907, 3478.756, 58.82272, 4.34155, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+182, 25377, 571, 0, 0, '0', 0, 0, 0, 3906.862, 3476.329, 57.79526, 3.9647, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+183, 25377, 571, 0, 0, '0', 0, 0, 0, 3895.673, 3488.134, 52.07495, 0.5125694, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+184, 25377, 571, 0, 0, '0', 0, 0, 0, 3934.134, 3506.953, 51.67665, 6.170922, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+185, 25377, 571, 0, 0, '0', 0, 0, 0, 3926.452, 3498.807, 52.40866, 3.861535, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+186, 25377, 571, 0, 0, '0', 0, 0, 0, 3910.824, 3485.944, 56.78598, 3.885894, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+187, 25377, 571, 0, 0, '0', 0, 0, 0, 3903.06, 3480.468, 56.38156, 2.333228, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+188, 25377, 571, 0, 0, '0', 0, 0, 0, 3928.13, 3507.663, 50.407, 3.513032, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+189, 25377, 571, 0, 0, '0', 0, 0, 0, 3920.079, 3496.129, 52.42612, 4.809077, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+190, 25377, 571, 0, 0, '0', 0, 0, 0, 3889.21, 3490.374, 51.28994, 1.190738, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+191, 25377, 571, 0, 0, '0', 0, 0, 0, 3919.065, 3487.513, 55.48593, 0.6557075, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+192, 25377, 571, 0, 0, '0', 0, 0, 0, 3922.625, 3502.891, 50.90102, 4.851348, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+193, 25377, 571, 0, 0, '0', 0, 0, 0, 3906.744, 3481.154, 57.70981, 1.442585, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+194, 25377, 571, 0, 0, '0', 0, 0, 0, 3928.391, 3503.573, 51.66494, 4.89102, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+195, 25377, 571, 0, 0, '0', 0, 0, 0, 3882.106, 3496.834, 49.87026, 1.449227, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+196, 25377, 571, 0, 0, '0', 0, 0, 0, 3888.425, 3495.322, 50.66372, 1.623445, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+197, 25377, 571, 0, 0, '0', 0, 0, 0, 3889.816, 3492.876, 51.08229, 2.999852, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+198, 25377, 571, 0, 0, '0', 0, 0, 0, 3886.697, 3494.933, 50.59719, 1.346169, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25377 (Area: 4125)
(@CGUID+199, 15214, 571, 0, 0, '0', 0, 0, 0, 3907.229, 3491.578, 51.694, 3.174816, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 15214 (Area: 4125) (Auras: )
(@CGUID+200, 25383, 571, 0, 0, '0', 0, 0, 0, 3969.229, 3475.197, 99.36195, 6.161329, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25383 (Area: -1) (Auras: 45617 - 45617)
(@CGUID+201, 25390, 571, 0, 0, '0', 0, 0, 0, 3736.273, 3590.903, 47.99994, 0.8899633, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+202, 25390, 571, 0, 0, '0', 0, 0, 0, 3741.549, 3619.058, 51.74624, 5.868149, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+203, 25390, 571, 0, 0, '0', 0, 0, 0, 3733.602, 3597.179, 49.17873, 5.992009, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+204, 25390, 571, 0, 0, '0', 0, 0, 0, 3755.551, 3614.849, 47.53596, 1.73466, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+205, 25390, 571, 0, 0, '0', 0, 0, 0, 3737.5, 3595.834, 47.55792, 3.263225, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+206, 25390, 571, 0, 0, '0', 0, 0, 0, 3745.494, 3614.806, 51.02425, 3.739824, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+207, 25390, 571, 0, 0, '0', 0, 0, 0, 3731.61, 3608.116, 50.42838, 4.519621, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+208, 25390, 571, 0, 0, '0', 0, 0, 0, 3746.177, 3610.937, 49.4919, 0.9030718, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+209, 25390, 571, 0, 0, '0', 0, 0, 0, 3740.296, 3606.416, 47.89117, 0.3061525, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+210, 25390, 571, 0, 0, '0', 0, 0, 0, 3739.774, 3586.381, 47.40804, 3.840582, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+211, 25390, 571, 0, 0, '0', 0, 0, 0, 3732.172, 3492.803, 66.06441, 4.919724, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+212, 25390, 571, 0, 0, '0', 0, 0, 0, 3722.42, 3474.34, 67.72371, 3.546465, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+213, 25390, 571, 0, 0, '0', 0, 0, 0, 3737.281, 3457.207, 68.44443, 6.275373, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+214, 25390, 571, 0, 0, '0', 0, 0, 0, 3735.691, 3481.298, 66.37328, 0.4247686, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+215, 25390, 571, 0, 0, '0', 0, 0, 0, 3762.339, 3460.782, 66.84665, 1.272987, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+216, 25390, 571, 0, 0, '0', 0, 0, 0, 3727.58, 3472.093, 67.7375, 6.149167, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+217, 25390, 571, 0, 0, '0', 0, 0, 0, 3729.184, 3463.325, 67.98989, 4.915916, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+218, 25390, 571, 0, 0, '0', 0, 0, 0, 3755.908, 3451.033, 68.73743, 1.29019, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+219, 25390, 571, 0, 0, '0', 0, 0, 0, 3752.901, 3443.411, 69.78725, 2.859401, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+220, 25390, 571, 0, 0, '0', 0, 0, 0, 3750.83, 3453.531, 68.79379, 3.341931, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: -1) (Auras: )
(@CGUID+221, 25390, 571, 0, 0, '0', 0, 0, 0, 3929.295, 3386.144, 81.46214, 2.466242, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4137) (Auras: )
(@CGUID+222, 25390, 571, 0, 0, '0', 0, 0, 0, 3932.021, 3374.059, 87.41148, 4.779801, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4137) (Auras: )
(@CGUID+223, 25390, 571, 0, 0, '0', 0, 0, 0, 3944.585, 3379.264, 85.34169, 2.193203, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4137) (Auras: )
(@CGUID+224, 25390, 571, 0, 0, '0', 0, 0, 0, 3945.311, 3386.357, 83.06496, 4.791557, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4137) (Auras: )
(@CGUID+225, 25390, 571, 0, 0, '0', 0, 0, 0, 3936.851, 3379.988, 84.34169, 1.985053, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4137) (Auras: )
(@CGUID+226, 25390, 571, 0, 0, '0', 0, 0, 0, 3956.039, 3386.022, 85.27751, 2.646924, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+227, 25390, 571, 0, 0, '0', 0, 0, 0, 3959.361, 3380.454, 88.27145, 3.735828, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+228, 25390, 571, 0, 0, '0', 0, 0, 0, 3995.549, 3396.604, 84.01167, 0.8137251, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+229, 25390, 571, 0, 0, '0', 0, 0, 0, 3990.87, 3410.72, 81.53675, 1.899959, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+230, 25390, 571, 0, 0, '0', 0, 0, 0, 4013.035, 3418.461, 87.39, 2.682534, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+231, 25390, 571, 0, 0, '0', 0, 0, 0, 4001.696, 3381.575, 94.27975, 0.1066663, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+232, 25390, 571, 0, 0, '0', 0, 0, 0, 4024.305, 3401.739, 88.4791, 4.252826, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+233, 25390, 571, 0, 0, '0', 0, 0, 0, 3975.886, 3386.318, 85.93647, 4.24115, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+234, 25390, 571, 0, 0, '0', 0, 0, 0, 4007.21, 3378.432, 96.99988, 5.743998, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+235, 25390, 571, 0, 0, '0', 0, 0, 0, 4026.654, 3411.017, 91.08331, 5.944759, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+236, 25390, 571, 0, 0, '0', 0, 0, 0, 4012.055, 3402.248, 88.56646, 5.85402, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+237, 25390, 571, 0, 0, '0', 0, 0, 0, 4005.33, 3387.403, 91.97034, 5.87855, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+238, 25390, 571, 0, 0, '0', 0, 0, 0, 4005.748, 3425.867, 87.4854, 1.783322, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+239, 25390, 571, 0, 0, '0', 0, 0, 0, 4007.662, 3406.613, 88.17662, 4.847075, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+240, 25390, 571, 0, 0, '0', 0, 0, 0, 4042.685, 3403.342, 93.21573, 1.982871, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+241, 25396, 571, 0, 0, '0', 0, 0, 0, 4042.685, 3403.342, 93.21573, 1.982871, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+242, 25396, 571, 0, 0, '0', 0, 0, 0, 3762.961, 3542.919, 294.694, 2.338741, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+243, 25396, 571, 0, 0, '0', 0, 0, 0, 3753.642, 3536.274, 294.782, 1.797689, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+244, 26103, 571, 0, 0, '0', 0, 0, 0, 3769.170, 3521.482, 347.866, 2.2045, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+245, 26103, 571, 0, 0, '0', 0, 0, 0, 3722.833, 3486.375, 347.87, 1.36023, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+246, 26103, 571, 0, 0, '0', 0, 0, 0, 3709.010, 3613.184, 347.866, 5.259722, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+247, 26094, 571, 0, 0, '0', 0, 0, 0, 3743.336, 3547.376, 353.033, 5.259722, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+248, 26094, 571, 0, 0, '0', 0, 0, 0, 3756.085, 3555.942, 352.890, 5.259722, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420), -- 25390 (Area: 4125) (Auras: )
(@CGUID+249, 26094, 571, 0, 0, '0', 0, 0, 0, 3728.194, 3550.65, 353.00, 5.259722, 120, 0, 0, 0, 0, 0, 0, 0, 0, 23420); -- 25390 (Area: 4125) (Auras: )

UPDATE `creature` SET `spawntimesecs` = 300 , `wander_distance` = 3 , `MovementType` = 1 WHERE `id` IN (25377, 25390);
UPDATE `creature` SET `spawntimesecs` = 300 , `wander_distance` = 0 , `MovementType` = 0 WHERE `id` IN (26093, 26094, 25378, 25383);
UPDATE `creature` SET `spawntimesecs` = 300 , `wander_distance` = 7 , `MovementType` = 1 WHERE `id` = 25393;
UPDATE `creature` SET  `spawntimesecs` = 300   WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+249;
UPDATE `creature` SET  `wander_distance` = 0 , `MovementType` = 0 WHERE `guid` IN (118319, 100032, 100034, 85215, 85121, 100059, 85206, 109630, 107628); 
UPDATE `creature` SET `position_x`=3876.965,`position_y`=3675.559,`position_z`=46.845  WHERE `guid` =100571;
UPDATE `creature` SET `position_x`=3941.666,`position_y`=3574.805,`position_z`=69.950  WHERE `guid` =100505;
UPDATE `creature` SET `position_x`=3965.341,`position_y`=3603.879,`position_z`=72.720  WHERE `guid` =100503;
UPDATE `creature` SET `position_x`=3924.658,`position_y`=3624.454,`position_z`=70.797  WHERE `guid` =100559;
UPDATE `creature` SET `position_x`=3825.789,`position_y`=3742.629,`position_z`=51.733  WHERE `guid` =98971;
UPDATE `creature` SET `position_x`=3814.749,`position_y`=3731.839,`position_z`=53.006  WHERE `guid` =98953;

-- ============================================================================
-- 32. fb66b9d - DB/Map: Add missing npcs and gameobjects on the old Champion's Hall & Hall of Legends instances
-- Source: https://github.com/LegionEmulationProject/AshamaneCore/commit/fb66b9d
-- ============================================================================
SET @CGUID:=106933;
SET @OGUID:=9838;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+20;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES 
(@CGUID+0, 19850, 450, 0, 0, '0', 0, 0, 0, 242.672, 88.56271, 24.85976, 4.468043, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 19850 (Area: 2917)
(@CGUID+1, 12788, 450, 0, 0, '0', 0, 0, 0, 239.8767, 85.61234, 24.85976, 6.126106, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12788 (Area: 2917)
(@CGUID+2, 12789, 450, 0, 0, '0', 0, 0, 0, 246.2953, 86.5842, 24.85976, 3.717551, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12789 (Area: 2917)
(@CGUID+3, 12790, 450, 0, 0, '0', 0, 0, 0, 239.8862, 84.12804, 24.85485, 1.117011, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12790 (Area: 2917)
(@CGUID+4, 12791, 450, 0, 0, '0', 0, 0, 0, 246.83, 82.42137, 24.84535, 2.565634, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12791 (Area: 2917)
(@CGUID+5, 12793, 450, 0, 0, '0', 0, 0, 0, 256.4854, 99.39707, 25.8042, 3.961897, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12793 (Area: 2917)
(@CGUID+6, 12794, 450, 0, 0, '0', 0, 0, 0, 240.6157, 103.3161, 25.80486, 4.852015, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12794 (Area: 2917)
(@CGUID+7, 12795, 450, 0, 0, '0', 0, 0, 0, 256.5978, 70.66988, 25.80373, 2.321288, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12795 (Area: 2917)
(@CGUID+8, 12796, 450, 0, 0, '0', 0, 0, 0, 258.9629, 73.2198, 25.80449, 2.495821, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12796 (Area: 2917)
(@CGUID+9, 12797, 450, 0, 0, '0', 0, 0, 0, 230.8099, 86.72803, 25.80155, 6.126106, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12797 (Area: 2917)
(@CGUID+10, 12798, 450, 0, 0, '0', 0, 0, 0, 238.2137, 73.37591, 25.79806, 1.186824, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12798 (Area: 2917)
(@CGUID+11, 12784, 449, 0, 0, '0', 0, 0, 0, 7.163939, 4.268201, -0.1725506, 0.08726646, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12784 (Area: 2918)
(@CGUID+12, 12785, 449, 0, 0, '0', 0, 0, 0, -9.118941, -4.266961, 5.570964, 0.1396263, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12785 (Area: 2918)
(@CGUID+13, 12786, 449, 0, 0, '0', 0, 0, 0, -2.744659, 3.605767, -0.1725506, 0.05235988, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12786 (Area: 2918) (Auras: 5301 - 5301)
(@CGUID+14, 12787, 449, 0, 0, '0', 0, 0, 0, 2.045413, 3.637273, -0.1725517, 3.106686, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12787 (Area: 2918) (Auras: 5301 - 5301)
(@CGUID+15, 12778, 449, 0, 0, '0', 0, 0, 0, -2.794709, 29.68436, 1.181421, 6.056293, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12778 (Area: 2918) (Auras: 5301 - 5301)
(@CGUID+16, 12779, 449, 0, 0, '0', 0, 0, 0, -0.993629, 31.69748, 1.181421, 5.044002, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12779 (Area: 2918)
(@CGUID+17, 12780, 449, 0, 0, '0', 0, 0, 0, 2.650486, 29.71008, 1.181421, 3.438299, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12780 (Area: 2918) (Auras: 134735 - 134735)
(@CGUID+18, 12781, 449, 0, 0, '0', 0, 0, 0, -3.685594, 15.15136, -0.1725487, 5.497787, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12781 (Area: 2918)
(@CGUID+19, 12783, 449, 0, 0, '0', 0, 0, 0, 6.308641, 34.95754, 1.139165, 4.852015, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706), -- 12783 (Area: 2918)
(@CGUID+20, 19848, 449, 0, 0, '0', 0, 0, 0, 1.562388, 32.09954, 1.181421, 4.206244, 7200, 0, 0, 0, 0, 0, 0, 0, 0, '', 23706); -- 19848 (Area: 2918) (Auras: 5301 - 5301)


DELETE FROM `creature_addon` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+20;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES 
(@CGUID+0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, ''), -- 19850
(@CGUID+1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, ''), -- 12788
(@CGUID+2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, ''), -- 12789
(@CGUID+3, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, ''), -- 12790
(@CGUID+4, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, ''), -- 12791
(@CGUID+5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 12793
(@CGUID+6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 12794
(@CGUID+7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 12795
(@CGUID+8, 0, 14334, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 12796
(@CGUID+9, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, ''), -- 12797
(@CGUID+10, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, ''), -- 12798
(@CGUID+11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), -- 12784
(@CGUID+12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 12785
(@CGUID+13, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, '5301'), -- 12786 - 5301 - 5301
(@CGUID+14, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, '5301'), -- 12787 - 5301 - 5301
(@CGUID+15, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, '5301'), -- 12778 - 5301 - 5301
(@CGUID+16, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, ''), -- 12779
(@CGUID+17, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, '134735'), -- 12780 - 134735 - 134735
(@CGUID+18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, ''), -- 12781
(@CGUID+19, 0, 14337, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''), -- 12783
(@CGUID+20, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, '5301'); -- 19848 - 5301 - 5301

DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+28;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@OGUID+0, 176564, 450, 0, 0, '0', 0, 93.97388, -102.6958, -14.8986, 3.141593, 0, 0, -1, 0, 7200, 255, 1, '', 23706), -- 176564 (Area: 2917)
(@OGUID+1, 176565, 450, 0, 0, '0', 0, 104.1366, -94.58491, -14.8986, 3.141593, 0, 0, -1, 0, 7200, 255, 1, '', 23706), -- 176565 (Area: 2917)
(@OGUID+2, 176567, 450, 0, 0, '0', 0, 251.4892, 94.47144, 25.82602, 0.9686573, 0, 0, 0.4656143, 0.8849878, 7200, 255, 1, '', 23706), -- 176567 (Area: 2917)
(@OGUID+3, 176568, 450, 0, 0, '0', 0, 255.7042, 85.47333, 25.82601, 5.715955, 0, 0, -0.2798281, 0.9600501, 7200, 255, 1, '', 23706), -- 176568 (Area: 2917)
(@OGUID+4, 176569, 450, 0, 0, '0', 0, 252.4974, 76.7461, 25.82602, 5.000368, 0, 0, -0.5983248, 0.8012537, 7200, 255, 1, '', 23706), -- 176569 (Area: 2917)
(@OGUID+5, 176570, 450, 0, 0, '0', 0, 242.5849, 97.20764, 25.82602, 1.195549, 0, 0, 0.5628042, 0.8265902, 7200, 255, 1, '', 23706), -- 176570 (Area: 2917)
(@OGUID+6, 176571, 450, 0, 0, '0', 0, 230.5504, 83.68984, 25.79818, 1.195549, 0, 0, 0.5628042, 0.8265902, 7200, 255, 1, '', 23706), -- 176571 (Area: 2917)
(@OGUID+7, 176572, 450, 0, 0, '0', 0, 235.8291, 74.55625, 25.79817, 2.932139, 0, 0, 0.9945211, 0.1045355, 7200, 255, 1, '', 23706), -- 176572 (Area: 2917)
(@OGUID+8, 179707, 450, 0, 0, '0', 0, 242.9785, 87.13777, 25.80421, 4.904376, 0, 0, -0.6360779, 0.7716249, 7200, 255, 1, '', 23706), -- 179707 (Area: 2917)
(@OGUID+9, 176575, 449, 0, 0, '0', 0, -2.51994, -2.907281, 0, 4.71239, 0, 0, -0.7071066, 0.7071069, 7200, 255, 0, '', 23706), -- 176575 (Area: 2918)
(@OGUID+10, 176384, 449, 0, 0, '0', 0, -9.025304, 28.0725, 1.060977, 0, 0, 0, 0, 1, 7200, 255, 1, '', 23706), -- 176384 (Area: 2918)
(@OGUID+11, 176385, 449, 0, 0, '0', 0, -9.025304, 30.1114, 1.060977, 0, 0, 0, 0, 1, 7200, 255, 1, '', 23706), -- 176385 (Area: 2918)
(@OGUID+12, 176386, 449, 0, 0, '0', 0, 7.123021, 12.036, -0.244337, 6.265733, 0, 0, -0.00872612, 0.9999619, 7200, 255, 1, '', 23706), -- 176386 (Area: 2918)
(@OGUID+13, 176387, 449, 0, 0, '0', 0, 6.827271, 6.826454, -0.244337, 0.1919852, 0, 0, 0.09584522, 0.9953963, 7200, 255, 1, '', 23706), -- 176387 (Area: 2918)
(@OGUID+14, 176388, 449, 0, 0, '0', 0, -4.759789, 14.60685, -0.244337, 1.762782, 0, 0, 0.7716246, 0.6360782, 7200, 255, 1, '', 23706), -- 176388 (Area: 2918)
(@OGUID+15, 179706, 449, 0, 0, '0', 0, 0.097743, 29.08226, 2.431421, 4.642576, 0, 0, -0.7313538, 0.6819983, 7200, 255, 1, '', 23706), -- 179706 (Area: 2918)
(@OGUID+16, 176371, 449, 0, 0, '0', 0, 0.9554105, -5.705855, 5.482604, 1.570796, 0, 0, 0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176371 (Area: 2918)
(@OGUID+17, 176372, 449, 0, 0, '0', 0, -0.9882749, -1.428213, 5.482604, 4.71239, 0, 0, -0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176372 (Area: 2918)
(@OGUID+18, 176373, 449, 0, 0, '0', 0, 3.012539, -3.597334, 5.482604, 3.089183, 0, 0, 0.9996567, 0.02620165, 7200, 255, 1, '', 23706), -- 176373 (Area: 2918)
(@OGUID+19, 176374, 449, 0, 0, '0', 0, -2.825732, -3.589562, 5.482604, 6.248281, 0, 0, -0.01745129, 0.9998477, 7200, 255, 1, '', 23706), -- 176374 (Area: 2918)
(@OGUID+20, 176375, 449, 0, 0, '0', 0, -1.028992, -5.617584, 5.482604, 1.570796, 0, 0, 0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176375 (Area: 2918)
(@OGUID+21, 176376, 449, 0, 0, '0', 0, 0.8865891, -1.410038, 5.482604, 4.71239, 0, 0, -0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176376 (Area: 2918)
(@OGUID+22, 176377, 449, 0, 0, '0', 0, 1.447738, 36.5178, 1.060977, 4.71239, 0, 0, -0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176377 (Area: 2918)
(@OGUID+23, 176378, 449, 0, 0, '0', 0, -2.752622, 36.49962, 1.060977, 4.71239, 0, 0, -0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176378 (Area: 2918)
(@OGUID+24, 176379, 449, 0, 0, '0', 0, -0.5911672, 36.5178, 1.060977, 4.71239, 0, 0, -0.7071066, 0.7071069, 7200, 255, 1, '', 23706), -- 176379 (Area: 2918)
(@OGUID+25, 176380, 449, 0, 0, '0', 0, 8.186553, 30.15226, 1.060977, 3.141593, 0, 0, -1, 0, 7200, 255, 1, '', 23706), -- 176380 (Area: 2918)
(@OGUID+26, 176381, 449, 0, 0, '0', 0, 8.204728, 27.9908, 1.060977, 3.141593, 0, 0, -1, 0, 7200, 255, 1, '', 23706), -- 176381 (Area: 2918)
(@OGUID+27, 176382, 449, 0, 0, '0', 0, 8.204729, 25.95189, 1.060977, 3.141593, 0, 0, -1, 0, 7200, 255, 1, '', 23706), -- 176382 (Area: 2918)
(@OGUID+28, 176383, 449, 0, 0, '0', 0, -9.007128, 25.91104, 1.060977, 0, 0, 0, 0, 1, 7200, 255, 1, '', 23706); -- 176383 (Area: 2918)

-- ============================================================================
-- WARNINGS
-- ============================================================================
-- f305c76 skipped 335 SQL paths: sql/ashamane/world/2020_04_16_03_world_2017_03_26_01_world_335.sql
