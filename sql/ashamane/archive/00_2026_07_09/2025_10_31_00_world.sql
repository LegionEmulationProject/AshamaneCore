-- Terrainswap for The Mission Alliance Pandaria Intro

-- Terrainswap Condition
DELETE FROM `conditions` WHERE `SourceEntry`=1066;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(25, 0, 1066, 0, 0, 6, 0, 469, 0, 0, 0, 0, 0, '', 'Apply Terrian swap 1066 if player is Alliance'),
(25, 0, 1066, 0, 0, 47, 0, 29548, 8, 0, 0, 0, 0, '', 'Apply Terrain swap 1066 if quest 29548 is taken');

-- terrain swap defaults
DELETE FROM `terrain_swap_defaults` WHERE `TerrainSwapMap`=1066;
INSERT INTO `terrain_swap_defaults` (`MapId`, `TerrainSwapMap`, `Comment`) VALUES 
(0, 1066, 'Skyfire Stormwind Harbor');


