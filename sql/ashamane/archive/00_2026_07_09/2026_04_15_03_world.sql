-- Handle all phases for quest 34392. Credits Aquadeus Trinitycore.

DELETE FROM `phase_area` WHERE `AreaId` IN (7025, 7037) AND `PhaseId` IN (3946, 3947, 3948, 4142, 4143, 4150, 4151, 3763, 3764);
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7025, 3946, 'See Dark Portal opened (Assault on the Dark Portal)'),
(7025, 3947, 'See Dark Portal half opened (Assault on the Dark Portal)'),
(7025, 3948, 'See Dark Portal almost closed (Assault on the Dark Portal)'),
(7025, 4142, 'See Northern Fel Spire enabled (Assault on the Dark Portal)'),
(7025, 4143, 'See Southern Fel Spire enabled (Assault on the Dark Portal)'),
(7025, 4150, 'See Northern Fel Spire disabled (Assault on the Dark Portal)'),
(7025, 4151, 'See Southern Fel Spire disabled (Assault on the Dark Portal)'),
(7037, 3763, 'See Cho\'gall in Fel Prison (Assault on the Dark Portal)'),
(7037, 3764, 'See Teron\'gor in Fel Prison (Assault on the Dark Portal)');

-- Conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3946 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3946, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 3946 if Quest 34392 is not complete | rewarded'),
(26, 3946, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3946 if QuestObjective 272621 is not complete'),
(26, 3946, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3946 if QuestObjective 273946 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3947 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3947, 0, 0, 0, 47, 0, 34392, 8, 0, 0, 'Apply Phase 3947 if Quest 34392 is in progress'),
(26, 3947, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 272621 is not complete'),
(26, 3947, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 273946 is complete'),
(26, 3947, 0, 0, 1, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 272621 is complete'),
(26, 3947, 0, 0, 1, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3947 if QuestObjective 273946 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3948 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3948, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 0, 'Apply Phase 3948 if Quest 34392 is complete | rewarded'),
(26, 3948, 0, 0, 0, 47, 0, 34393, 2 | 64, 0, 1, 'Apply Phase 3948 if Quest 34393 is not complete | rewarded');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4142 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4142, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 4142 if Quest 34392 is not complete | rewarded'),
(26, 4142, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 4142 if QuestObjective 272621 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4143 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4143, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 4143 if Quest 34392 is not complete | rewarded'),
(26, 4143, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 4143 if QuestObjective 273946 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4150 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4150, 0, 0, 0, 47, 0, 34392, 2 | 8 | 64, 0, 0, 'Apply Phase 4150 if Quest 34392 is in progress | complete | rewarded'),
(26, 4150, 0, 0, 0, 48, 0, 272621, 0, 0, 0, 'Apply Phase 4150 if QuestObjective 272621 is complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4151 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4151, 0, 0, 0, 47, 0, 34392, 2 | 8 | 64, 0, 0, 'Apply Phase 4151 if Quest 34392 is in progress | complete | rewarded'),
(26, 4151, 0, 0, 0, 48, 0, 273946, 0, 0, 0, 'Apply Phase 4151 if QuestObjective 273946 is complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3763 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3763, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 3763 if Quest 34392 is not in progress | complete | rewarded'),
(26, 3763, 0, 0, 0, 48, 0, 272621, 0, 0, 1, 'Apply Phase 3763 if QuestObjective 272621 is not complete');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 3764 AND `SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 3764, 0, 0, 0, 47, 0, 34392, 2 | 64, 0, 1, 'Apply Phase 3764 if Quest 34392 is not in progress | complete | rewarded'),
(26, 3764, 0, 0, 0, 48, 0, 273946, 0, 0, 1, 'Apply Phase 3764 if QuestObjective 273946 is not complete');
