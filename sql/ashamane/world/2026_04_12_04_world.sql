-- =========================================================
-- 28608 - The Shadow Grave
-- Final DB patch for C++ implementation
--
-- What this does:
--   * removes old Darnell SAI artifacts
--   * removes old DB waypoint path attempts no longer used
--   * keeps Darnell creature_text for C++ Talk()
--   * binds Darnell, Mordo, and helper triggers to C++
--   * adds stair helper triggers 300000049 and 300000050
--
-- What this does NOT do anymore:
--   * no waypoint_data path for Darnell
--   * no waypoint table usage
--   * no SmartAI for Darnell/helper triggers
-- =========================================================

SET @DARNELL := 49141;
SET @MORDO   := 1568;
SET @SRC_GUID := 20000003;

SET @STAIR_GUID_1 := 300000049;
SET @STAIR_GUID_2 := 300000050;

-- ---------------------------------------------------------
-- Remove Darnell/helper SAI artifacts
-- ---------------------------------------------------------
DELETE FROM `smart_scripts`
WHERE (`entryorguid` = @DARNELL AND `source_type` = 0)
   OR (`entryorguid` IN (4914100, 4914101, 4914102, 4914103, 4914104) AND `source_type` = 9)
   OR (`entryorguid` IN (-20000002, -192770, -20000003, -192772, -300000049, -300000050) AND `source_type` = 0);

-- ---------------------------------------------------------
-- Remove old DB movement attempts no longer used
-- ---------------------------------------------------------
DELETE FROM `waypoint_data` WHERE `id` = @DARNELL;
DELETE FROM `waypoints`     WHERE `entry` = @DARNELL;

-- ---------------------------------------------------------
-- Darnell creature_text used by C++ Talk(groupId)
-- ---------------------------------------------------------
DELETE FROM `creature_text`
WHERE `CreatureID` = @DARNELL;

INSERT INTO `creature_text`
(`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`)
VALUES
(@DARNELL, 0, 0, 'Greetings, $n.', 12, 0, 100, 1, 0, 0, 0, 0, 'Darnell - Greeting'),
(@DARNELL, 1, 0, 'This way!', 12, 0, 100, 1, 0, 0, 0, 0, 'Darnell - Start line'),
(@DARNELL, 2, 0, 'Now, where could those supplies be?', 12, 0, 100, 1, 0, 0, 0, 0, 'Darnell - Search line 1'),
(@DARNELL, 3, 0, 'Hmm...', 12, 0, 100, 1, 0, 0, 0, 0, 'Darnell - Search line 2'),
(@DARNELL, 4, 0, 'Hey, give me a hand, $n!  I can''t find the supplies that Mordo needed!', 12, 0, 100, 1, 0, 0, 0, 0, 'Darnell - Final help line'),
(@DARNELL, 5, 0, 'No, not over here.', 12, 0, 100, 1, 0, 0, 0, 0, 'Darnell - Search line 3');

-- ---------------------------------------------------------
-- Bind Darnell to C++
-- ---------------------------------------------------------
UPDATE `creature_template`
SET `AIName` = '',
    `ScriptName` = 'npc_darnell_shadow_grave'
WHERE `entry` = @DARNELL;

-- ---------------------------------------------------------
-- Bind existing invisible helper spawns to C++
-- These are per-spawn, not per-template
-- ---------------------------------------------------------
UPDATE `creature`
SET `ScriptName` = 'npc_shadow_grave_darnell_trigger'
WHERE `guid` IN (20000002, 192770, 20000003, 192772);

-- ---------------------------------------------------------
-- Add stair helper triggers by cloning source trigger 20000003
-- Source template/properties come from existing entry 41200 spawn
-- ---------------------------------------------------------
DELETE FROM `creature`
WHERE `guid` IN (@STAIR_GUID_1, @STAIR_GUID_2);

INSERT INTO `creature`
(
    `guid`,
    `id`,
    `map`,
    `zoneId`,
    `areaId`,
    `spawnDifficulties`,
    `PhaseId`,
    `PhaseGroup`,
    `modelid`,
    `equipment_id`,
    `position_x`,
    `position_y`,
    `position_z`,
    `orientation`,
    `spawntimesecs`,
    `wander_distance`,
    `currentwaypoint`,
    `curhealth`,
    `curmana`,
    `MovementType`,
    `npcflag`,
    `unit_flags`,
    `unit_flags2`,
    `unit_flags3`,
    `dynamicflags`,
    `VerifiedBuild`
)
SELECT
    @STAIR_GUID_1,
    `id`,
    `map`,
    `zoneId`,
    `areaId`,
    `spawnDifficulties`,
    `PhaseId`,
    `PhaseGroup`,
    `modelid`,
    `equipment_id`,
    1642.693237,
    1663.235352,
    132.477325,
    0,
    `spawntimesecs`,
    0,
    0,
    `curhealth`,
    `curmana`,
    0,
    `npcflag`,
    `unit_flags`,
    `unit_flags2`,
    `unit_flags3`,
    `dynamicflags`,
    `VerifiedBuild`
FROM `creature`
WHERE `guid` = @SRC_GUID;

INSERT INTO `creature`
(
    `guid`,
    `id`,
    `map`,
    `zoneId`,
    `areaId`,
    `spawnDifficulties`,
    `PhaseId`,
    `PhaseGroup`,
    `modelid`,
    `equipment_id`,
    `position_x`,
    `position_y`,
    `position_z`,
    `orientation`,
    `spawntimesecs`,
    `wander_distance`,
    `currentwaypoint`,
    `curhealth`,
    `curmana`,
    `MovementType`,
    `npcflag`,
    `unit_flags`,
    `unit_flags2`,
    `unit_flags3`,
    `dynamicflags`,
    `VerifiedBuild`
)
SELECT
    @STAIR_GUID_2,
    `id`,
    `map`,
    `zoneId`,
    `areaId`,
    `spawnDifficulties`,
    `PhaseId`,
    `PhaseGroup`,
    `modelid`,
    `equipment_id`,
    1642.755493,
    1677.718262,
    126.931999,
    0,
    `spawntimesecs`,
    0,
    0,
    `curhealth`,
    `curmana`,
    0,
    `npcflag`,
    `unit_flags`,
    `unit_flags2`,
    `unit_flags3`,
    `dynamicflags`,
    `VerifiedBuild`
FROM `creature`
WHERE `guid` = @SRC_GUID;

-- Bind new stair helper spawns to C++
UPDATE `creature`
SET `ScriptName` = 'npc_shadow_grave_darnell_trigger'
WHERE `guid` IN (@STAIR_GUID_1, @STAIR_GUID_2);

-- ---------------------------------------------------------
-- Bind Undertaker Mordo quest accept to C++
-- Safe version: only set if empty or already this script name
-- If 1568 already has a different C++ ScriptName in your DB,
-- merge the OnQuestAccept into that existing script instead.
-- ---------------------------------------------------------
UPDATE `creature_template`
SET `AIName` = '',
    `ScriptName` = 'npc_undertaker_mordo_shadow_grave'
WHERE `entry` = @MORDO
  AND (`ScriptName` = '' OR `ScriptName` = 'npc_undertaker_mordo_shadow_grave');

  -- Remove any existing Lilian summon from Caice's actionlist
DELETE FROM smart_scripts
WHERE entryorguid = 230700
  AND source_type = 9
  AND action_type = 12
  AND action_param1 = 38895;

-- Clone the working Redpath summon row and turn it into Lilian
INSERT INTO smart_scripts
(
    entryorguid, source_type, id, link,
    event_type, event_phase_mask, event_chance, event_flags,
    event_param1, event_param2, event_param3, event_param4, event_param5, event_param_string,
    action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6,
    target_type, target_param1, target_param2, target_param3,
    target_x, target_y, target_z, target_o,
    comment
)
SELECT
    230700, source_type, 3, link,
    event_type, event_phase_mask, event_chance, event_flags,
    event_param1, event_param2, event_param3, event_param4, event_param5, event_param_string,
    action_type, 38895, action_param2, action_param3, action_param4, action_param5, action_param6,
    target_type, target_param1, target_param2, target_param3,
    1749.142944, 1674.074829, 121.187920, 0.78,
    'Caice - Actionlist - Summon Lilian Voss for The Wakening'
FROM smart_scripts
WHERE entryorguid = 230700
  AND source_type = 9
  AND action_type = 12
  AND action_param1 = 49230
LIMIT 1;

-- Verify all three summons now exist
SELECT
    entryorguid, source_type, id, action_type, action_param1,
    target_x, target_y, target_z, target_o, comment
FROM smart_scripts
WHERE entryorguid = 230700
  AND source_type = 9
ORDER BY id;