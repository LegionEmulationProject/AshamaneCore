DELETE FROM `lfg_dungeon_template` WHERE `dungeonId`=908;
INSERT INTO `lfg_dungeon_template` (`dungeonId`, `name`, `position_x`, `position_y`, `position_z`, `orientation`, `requiredItemLevel`, `VerifiedBuild`) VALUES 
(908, 'Battle for Brokenshore', 0, 0, 0, 0, 0, 0);

DELETE FROM `instance_template` WHERE `map`=1460;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`, `insideResurrection`) VALUES 
(1460, 0, '', 0, 1);

DELETE FROM `access_requirement` WHERE `mapId`=1460 AND `difficulty`=23;
INSERT INTO `access_requirement` (`mapId`, `difficulty`, `level_min`, `level_max`, `item`, `item2`, `quest_done_A`, `quest_done_H`, `completed_achievement`, `quest_failed_text`, `comment`) VALUES 
(1460, 23, 100, 0, 0, 0, 0, 0, 0, NULL, 'Battle for Brokenshore');

