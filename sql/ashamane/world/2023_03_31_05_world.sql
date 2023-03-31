-- Condition Terrainswap On Quest
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=25 AND `SourceEntry`=1190;
INSERT INTO `conditions` VALUES
(25, 0, 1190, 0, 0, 47, 2 | 8 | 64, 34398, 0, 0, 0, 0, 0, '', 'Terrainwap: Warlords of Draenor: The Dark Portal In Progress, Completed, Rewarded');

DELETE FROM `terrain_swap_defaults` WHERE `TerrainSwapMap` = 1190;
INSERT INTO `terrain_swap_defaults` (`MapId`, `TerrainSwapMap`, `Comment`) VALUES 
(0, 1190, 'Blasted Lands Draenor Phase');
