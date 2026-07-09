-- conversation The Dreadlords prize

DELETE FROM `conversation_template` WHERE `Id`=3364;
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(3364, 7069, 25979, 26365);

DELETE FROM `conversation_line_template` WHERE `Id` IN (7069, 7070, 7071, 7079);
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(7069, 0, 0, 0, 0, 26365),
(7070, 4733, 0, 0, 256, 26365),
(7071, 11355, 0, 0, 0, 26365),
(7079, 17638, 0, 0, 0, 26365);

DELETE FROM `conversation_actors` WHERE `ConversationId`=3364;
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(3364, 51396, 0, 26365);

-- Dreadlords Prize
SET @ENTRY := 41036;
UPDATE `quest_template_addon` SET `ScriptName` = 'SmartQuest' WHERE `ID` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 5 AND `entryOrGuid` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 5, 0, 0, 47, 0, 100, 0, 0, 0, 0, 0, 0, 143, 3364, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On quest accepted - Player who accepted: Start conversation 3364');
