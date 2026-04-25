DELETE FROM spell_script_names
WHERE spell_id IN (108194, 221562)
   OR ScriptName = 'spell_dk_asphyxiate';

INSERT INTO spell_script_names
(spell_id,ScriptName)
VALUES
(108194,'spell_dk_asphyxiate'),
(221562,'spell_dk_asphyxiate');