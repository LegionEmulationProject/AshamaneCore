DELETE FROM `terrain_swap_defaults` WHERE `MapId`=870 AND `TerrainSwapMap`=971;
INSERT INTO `terrain_swap_defaults` (`MapId`, `TerrainSwapMap`, `Comment`) VALUES
(870, 971, 'The Jade Forest - Jade Forest Alliance Hub Phase');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=25 AND `SourceEntry`=971;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(25,0,971,0,0,6,0,469,0,0,0,0,0,'','Apply terrain swap 971 if player is Alliance'),
(25,0,971,0,0,47,0,31736,64,0,1,0,0,'','Apply terrain swap 971 if quest 31736 is not rewarded');
