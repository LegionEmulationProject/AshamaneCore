SET @CGUID := 500037;

DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID+0 AND @CGUID+9;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID+0, 78569, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4072.632080078125, -2377.267333984375, 94.68717193603515625, 2.021764278411865234, 120, 0, 0, 12315, 0, 0, 0, 0, 0, 0), -- Hansel Heavyhands (Area: The Dark Portal - Difficulty: 0)
(@CGUID+1, 78556, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4066.55908203125, -2375.838623046875, 95.1081085205078125, 1.667772650718688964, 120, 0, 0, 12315, 0, 0, 0, 0, 0, 0), -- Ariok (Area: The Dark Portal - Difficulty: 0)
(@CGUID+2, 79315, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4069.50341796875, -2376.682373046875, 94.68717193603515625, 1.694566726684570312, 120, 0, 0, 12315, 0, 0, 0, 0, 0, 0), -- Olin Umberhide (Area: The Dark Portal - Difficulty: 0)
(@CGUID+3, 79316, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4064.01123046875, -2376.9306640625, 94.68717193603515625, 1.341159939765930175, 120, 0, 0, 12315, 1283, 0, 0, 0, 0, 0), -- Qiana Moonshadow (Area: The Dark Portal - Difficulty: 0)
(@CGUID+4, 78568, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4061.2353515625, -2377.041748046875, 94.68717193603515625, 0.983592748641967773, 120, 0, 0, 12315, 0, 0, 0, 0, 0, 0), -- Thaelin Darkanvil (Area: The Dark Portal - Difficulty: 0)
(@CGUID+5, 78558, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4066.50439453125, -2372.154541015625, 94.665191650390625, 1.596214056015014648, 120, 0, 0, 394200, 9573, 0, 0, 0, 0, 0), -- Archmage Khadgar (Area: The Dark Portal - Difficulty: 0)
(@CGUID+6, 78554, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4068.79248046875, -2372.776123046875, 94.687164306640625, 1.660148024559020996, 120, 0, 0, 2955600, 128300, 0, 0, 0, 0, 0), -- Vindicator Maraad (Area: The Dark Portal - Difficulty: 0) (Auras: 165747 - Blessing of Might)
(@CGUID+7, 78553, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4063.955810546875, -2373.505126953125, 94.687164306640625, 1.826755285263061523, 120, 0, 0, 2955600, 320750, 0, 0, 0, 0, 0), -- Thrall (Area: The Dark Portal - Difficulty: 0)
(@CGUID+8, 78430, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4061.217041015625, -2372.647705078125, 94.6811065673828125, 1.444518804550170898, 120, 0, 0, 246300, 100, 0, 0, 0, 0, 0), -- Cordana Felsong (Area: The Dark Portal - Difficulty: 0)
(@CGUID+9, 79675, 1265, 7025, 7037, '0', '3569', 0, 0, 0, 4071.169189453125, -2373.03466796875, 94.687164306640625, 1.607159137725830078, 120, 0, 0, 246300, 0, 0, 0, 0, 0, 0); -- Lady Liadrin (Area: The Dark Portal - Difficulty: 0)

DELETE FROM `creature_addon` WHERE `guid`=@CGUID+6;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `auras`) VALUES
(@CGUID+6, 0, 0, 0, 1, 0, 0, 0, 0, '165747'); -- Vindicator Maraad - 165747 - Blessing of Might

-- Phase
DELETE FROM `phase_area` WHERE `AreaId` = 7025 AND `PhaseId`=3569;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7025, 3569, 'See Named Characters on Dark Portal, Post-Guldan');

-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=26 AND `SourceGroup`=3569;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ScriptName`, `Comment`) VALUES
(26, 3569, 0, 0, 0, 47, 0, 34393, 66, 0, 0, '', 'Apply Phase 3569 if Quest 34393 is complete | rewarded'),
(26, 3569, 0, 0, 0, 47, 0, 34420, 1, 0, 1, '', 'Apply Phase 3569 if Quest 34420 is not taken');
