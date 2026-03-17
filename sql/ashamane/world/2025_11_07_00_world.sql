-- Conversation for Legion Returns

UPDATE `quest_template_addon` SET `ScriptName`='SmartQuest' WHERE `id`=40519;

DELETE FROM `conversation_actors` WHERE `ConversationId`=2507;
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(2507, 53609, 0, 26972);

DELETE FROM `conversation_actor_template` WHERE `Id`=53609;
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(53609, 108589, 70626, 26972);

DELETE FROM `conversation_line_template` WHERE `Id`=5310;
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(5310, 0, 82, 0, 0, 26972);

DELETE FROM `conversation_template` WHERE `Id`=2507;
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(2507, 5310, 19211, 26972);

DELETE FROM `smart_scripts` WHERE `entryorguid`=40519;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(40519, 5, 0, 0, 47, 0, 100, 0, 40519, 0, 0, 0, 0, '', 143, 2507, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On Quest Taken - Push Conversation');

