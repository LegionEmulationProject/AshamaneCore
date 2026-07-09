UPDATE `creature_template_addon` SET `SheathState`=0 WHERE `entry` IN (32643, 46406, 46417);
DELETE FROM `gameobject_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);
UPDATE `creature_template` SET `speed_walk`=1, `speed_run`=1.14286 WHERE `entry`=28850;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-129391, -129390, -125578);
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (1412, 16528, 16541, 17186);
UPDATE `scene_template` SET `ScriptName`='scene_odyn_intro' WHERE `SceneId`=1109;
UPDATE `creature_template` SET `npcflag`=`npcflag`^16777216 WHERE `entry`=91904;

DELETE FROM `waypoints` WHERE `entry`=11110910;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(11110910, 1, -819.372, 4410.23, 737.827, NULL),
(11110910, 2, -809.25, 4422.33, 738.198, NULL),
(11110910, 3, -802.134, 4432.33, 738.488, NULL),
(11110910, 4, -794.156, 4443.67, 737.698, NULL),
(11110910, 5, -783.123, 4459.32, 735.187, NULL),
(11110910, 6, -778.727, 4468.64, 734.357, NULL),
(11110910, 7, -776.012, 4482.85, 732.828, NULL),
(11110910, 8, -781.495, 4494.7, 731.816, NULL),
(11110910, 9, -794.993, 4508.38, 730.993, NULL),
(11110910, 10, -805.898, 4513.47, 730.718, NULL),
(11110910, 11, -820.627, 4525.25, 729.796, NULL),
(11110910, 12, -831.471, 4534.68, 729.117, NULL),
(11110910, 13, -847.038, 4546.31, 728.323, NULL),
(11110910, 14, -855.262, 4555.42, 727.883, NULL),
(11110910, 15, -859.993, 4564.86, 727.863, NULL),
(11110910, 16, -859.188, 4572.37, 732.83, NULL),
(11110910, 17, -858.069, 4582.41, 739.978, NULL),
(11110910, 18, -857.467, 4589.84, 745.636, NULL),
(11110910, 19, -856.764, 4595.34, 748.987, NULL),
(11110910, 20, -855.881, 4603.64, 749.443, NULL),
(11110910, 21, -854.554, 4609.09, 750.19, NULL),
(11110910, 22, -853.623, 4616.65, 749.65, NULL);

UPDATE `waypoints` SET `pointid`=4 WHERE `entry`=332660 AND `pointid`=3;
UPDATE `waypoints` SET `pointid`=3 WHERE `entry`=332660 AND `pointid`=2;
UPDATE `waypoints` SET `pointid`=2 WHERE `entry`=332660 AND `pointid`=1;
UPDATE `waypoints` SET `pointid`=1 WHERE `entry`=332660 AND `pointid`=0;
