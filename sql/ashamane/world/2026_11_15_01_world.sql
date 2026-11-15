-- Condition for Visibility
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 5 AND `SourceEntry` = 79243) OR (`SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 8 AND `SourceEntry` = 230280);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(32, 3, 79243, 0, 0, 47, 0, 34583, 66, 0, 0, 'Baros Alexston gets visible if Quest: 34583 is complete/rewarded'),
(32, 5, 230280, 0, 0, 9, 0, 34583, 0, 0, 0, 'Alliance Banner gets visible if Quest: 34583 is Taken'),
(32, 5, 230280, 0, 1, 47, 0, 34583, 66, 0, 0, 'OR: Alliance Banner gets visible if Quest: 34583 is complete/rewarded');
