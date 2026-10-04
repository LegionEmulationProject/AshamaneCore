-- An Unwelcome Guest (26509)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26509;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26509, 0, 0, 0, 0, 0, 0, 0, 0, 'Finally the menace is laid to rest!  Thank you, <name>, you have done me a great service.  The garden shall be in full bloom this season!', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26509;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26509, 0, 0, 0, 0, 'Is Bellygrub still at it or were you able to rid Lakeshire of the pest once and for all?', 0);