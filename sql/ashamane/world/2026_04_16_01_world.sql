DELETE FROM `phase_area` WHERE `AreaId` IN (7025, 7037) AND `PhaseId`IN (3248, 3249, 3250, 3251);
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7037, 3248, 'Ganahma\'s Barb under the Dark Portal (Assault on the Dark Portal)'),
(7037, 3249, 'Rune of the Felbreakers under the Dark Portal (Assault on the Dark Portal)'),
(7037, 3250, 'Horn of Kairozdormu under the Dark Portal (Assault on the Dark Portal)'),
(7037, 3251, 'Gul\'Dan under the Dark Portal (Assault on the Dark Portal)');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3248 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3248, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3248 if Quest 34393 is not complete | rewarded'),
(26, 3248, 7037, 0, 0, 48, 0, 273438, 0, 0, 1, 'Apply Phase 3248 if QuestObjective 273438 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3249 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3249, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3248 if Quest 34393 is not complete | rewarded'),
(26, 3249, 7037, 0, 0, 48, 0, 273556, 0, 0, 1, 'Apply Phase 3249 if QuestObjective 273556 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3250 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3250, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3250 if Quest 34393 is not complete | rewarded'),
(26, 3250, 7037, 0, 0, 48, 0, 273557, 0, 0, 1, 'Apply Phase 3250 if QuestObjective 273557 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3251 AND `SourceEntry` = 7037);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3251, 7037, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3251 if Quest 34393 is not complete | rewarded');
