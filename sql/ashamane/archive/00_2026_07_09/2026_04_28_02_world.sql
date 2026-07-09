-- Army of the Dead - Death Knight
-- Binds spell 42651 to C++ SpellScriptLoader: spell_dk_army_of_the_dead
-- World DB

DELETE FROM `spell_script_names`
WHERE `spell_id` = 42651
  AND `ScriptName` = 'spell_dk_army_of_the_dead';

INSERT INTO `spell_script_names`
(`spell_id`, `ScriptName`)
VALUES
(42651, 'spell_dk_army_of_the_dead');
