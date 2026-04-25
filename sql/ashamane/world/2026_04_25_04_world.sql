DELETE FROM `conversation_template` WHERE `Id`=1264;
INSERT INTO `conversation_template` (`Id`, `FirstLineID`, `LastLineEndTime`, `VerifiedBuild`) VALUES
(1264, 2982, 9842, 26365);

DELETE FROM `conversation_line_template` WHERE `Id`=2982;
INSERT INTO `conversation_line_template` (`Id`, `StartTime`, `UiCameraID`, `ActorIdx`, `Flags`, `VerifiedBuild`) VALUES
(2982, 0, 0, 0, 0, 26365);

DELETE FROM `conversation_actor_template` WHERE `id`=51396;
INSERT INTO `conversation_actor_template` (`Id`, `CreatureId`, `CreatureModelId`, `VerifiedBuild`) VALUES
(51396, 102850, 67760, 26365); -- Meryl Felstorm

DELETE FROM `conversation_actors` WHERE `ConversationId`=1264;
INSERT INTO `conversation_actors` (`ConversationId`, `ConversationActorId`, `Idx`, `VerifiedBuild`) VALUES
(1264, 51396, 0, 26365); -- Full: 0x00000000000000000000000000000000 Creature/0 R3149/S9980 Map: 1220 Entry: 102700 (Meryl Felstorm) Low: 451794
