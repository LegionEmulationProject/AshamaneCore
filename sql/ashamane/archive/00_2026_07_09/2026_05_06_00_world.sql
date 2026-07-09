SET @CGUID := 602003;

DELETE FROM `creature` WHERE `guid` = @CGUID;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`) VALUES
(@CGUID, 93337, 1220, 7334, 7334, '0', '4741', 0, 0, 1, -79.126739501953125, 6859.22119140625, 31.05942535400390625, 2.138637065887451171, 7200, 0, 0, 3765600, 950250, 0, 0, 0, 0, 0);

DELETE FROM `creature_template_addon` WHERE `entry`=93337;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `StandState`, `AnimTier`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`) VALUES
(93337, 0, 0, 0, 1, 0, 0, 0, 0, 0, '');

DELETE FROM `creature_equip_template` WHERE `CreatureID`=93337;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(93337, 1, 28067, 0, 0, 0, 0, 0, 0, 0, 0, 43340); -- 93337

DELETE FROM `creature_queststarter` WHERE (`id`=93337 AND `quest` IN (38834, 44137));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(93337, 38834),
(93337, 44137);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId`=26 AND `SourceGroup` = 4741  AND `SourceEntry` = 7334);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(26, 4741, 7334, 0, 0, 47, 0, 38834, 2 | 8 | 64, 0, 1, 'Apply Phase 4741 if Quest 38834 is not in progress | complete | rewarded'),
(26, 4741, 7334, 0, 0, 47, 0, 44137, 2 | 8 | 64, 0, 1, 'Apply Phase 4741 if Quest 44137 is not in progress | complete | rewarded');

DELETE FROM `phase_area` WHERE `AreaId` = 7334 AND `PhaseId` = 4741;
INSERT INTO `phase_area` (`AreaId`, `PhaseId`, `Comment`) VALUES
(7334, 4741, 'See Archmage Khadgar in Azsuna for Quest Into the Fray');
