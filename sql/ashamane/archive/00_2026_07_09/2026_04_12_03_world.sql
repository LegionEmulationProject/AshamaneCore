SET @CGUID := 500005;

DELETE FROM `creature` WHERE `guid`=@CGUID+0;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `VerifiedBuild`) VALUES
(@CGUID+0, 78423, 0, 4, 72, '0', 0, 0, 1190, 0, 1, -11812.2607421875, -3205.59716796875, -29.479166030883789, 3.093542814254760742, 120, 0, 0, 640000, 9573, 0, 0, 0, 0); -- Archmage Khadgar (Area: The Dark Portal - Difficulty: 0) CreateObject1 (Auras: 128281 - Moonbeam Visual)


DELETE FROM `creature_addon` WHERE `guid`=@CGUID+0;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvpFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(@CGUID+0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '128281'); -- Archmage Khadgar - 128281 - Moonbeam Visual

DELETE FROM `creature_equip_template` WHERE `CreatureID`=78423;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(78423, 1, 28067, 0, 0, 0, 0, 0, 0, 0, 0, 0); -- 78423
