-- Blink of an Eye SAI
UPDATE `quest_template_addon` SET `ScriptName`='SmartQuest' WHERE `id`=44663;

DELETE FROM `smart_scripts` WHERE `entryorguid`=44663 AND `source_type`=5 AND `id`=0 AND `link`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(44663, 5, 0, 0, 47, 0, 100, 0, 44663, 0, 0, 0, 0, '', 143, 3827, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Taken - Push Conversation');
