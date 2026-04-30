-- 2026_04_30_00_world.sql
-- Army of the Dead ghoul AI binding
-- Verified creature_template has ScriptName column from information_schema_COLUMNS.csv.
-- Army of the Dead Ghoul is commonly entry 24207. Verify against your local creature_template if your DB differs.

UPDATE `creature_template`
SET `ScriptName` = 'npc_pet_dk_army_of_the_dead_ghoul'
WHERE `entry` = 24207;
