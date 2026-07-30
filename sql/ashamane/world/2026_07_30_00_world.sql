DELETE FROM `spell_area` WHERE `spell` IN(164609, 164611);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `flags`, `quest_start_status`, `quest_end_status`) VALUES 
(164609, 7025, 34422, 35297, 0, 0, 2, 3, 10, 1),
(164611, 7025, 34422, 35297, 0, 0, 2, 3, 8, 1);

UPDATE `scene_template` SET `ScriptName`='scene_bleeding_hollow_holdout' WHERE `SceneId`=770;
UPDATE `scene_template` SET `ScriptName`='scene_bleeding_hollow_trail_of_flame' WHERE `SceneId`=771;
UPDATE `quest_template_addon` SET `ScriptName`='quest_blade_of_glory' WHERE `Id`=34422;
