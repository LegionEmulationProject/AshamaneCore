DELETE FROM `spell_script_names`
WHERE `spell_id` = 208278
  AND `ScriptName` = 'spell_dk_debilitating_infestation';

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(208278, 'spell_dk_debilitating_infestation');