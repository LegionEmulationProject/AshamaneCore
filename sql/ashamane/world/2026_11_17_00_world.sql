-- Condition for Visibility
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 3 AND `SourceEntry` = 79470) OR (`SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 3 AND `SourceEntry` = 79241) OR (`SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 3 AND `SourceEntry` = 79567);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(32, 3, 79470, 0, 0, 47, 0, 34582, 66, 0, 0, 'Vindicator Maraad gets visible if Quest: 34582 is complete/rewarded'),
(32, 3, 79241, 0, 0, 47, 0, 34582, 66, 0, 0, 'Prophet Velen gets visible if Quest: 34582 is complete/rewarded'),
(32, 3, 79567, 0, 0, 47, 0, 34582, 66, 0, 0, 'Yrel gets visible if Quest: 34582 is complete/rewarded');