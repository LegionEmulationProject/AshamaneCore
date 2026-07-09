-- Scarlet Land Cannon (Entry: 28850)
-- Make cannon stationary and use spell-only combat behavior.

-- Template-level fix: all Scarlet Land Cannon spawns use SmartAI and do not path/wander by default.
UPDATE `creature_template`
SET
    `AIName` = 'SmartAI',
    `MovementType` = 0,
    `speed_walk` = 0,
    `speed_run` = 0,
    `spell1` = 52539
WHERE `entry` = 28850;

-- Existing spawn cleanup: specifically lock current DB spawn(s) in place.
UPDATE `creature`
SET
    `MovementType` = 0,
    `wander_distance` = 0,
    `currentwaypoint` = 0
WHERE `id` = 28850;

-- Replace existing SmartAI for this template to avoid chase/melee behavior.
DELETE FROM `smart_scripts`
WHERE `entryorguid` = 28850
  AND `source_type` = 0;

INSERT INTO `smart_scripts`
(`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
 `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`,
 `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
 `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
-- On aggro: do not use melee swings.
(28850, 0, 0, 0, 4, 0, 100, 0,
 0, 0, 0, 0, 0, '',
 20, 0, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Land Cannon - On Aggro - Disable Auto Attack'),

-- On aggro: do not chase/move toward the target.
(28850, 0, 1, 0, 4, 0, 100, 0,
 0, 0, 0, 0, 0, '',
 21, 0, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Land Cannon - On Aggro - Disable Combat Movement'),

-- While in combat: cast cannon spell at the current victim.
(28850, 0, 2, 0, 0, 0, 100, 0,
 500, 1500, 2500, 3500, 0, '',
 11, 52539, 0, 0, 0, 0, 0,
 2, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Land Cannon - In Combat - Cast 52539');
