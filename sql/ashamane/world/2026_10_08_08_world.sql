-- Breaking Out is Hard to Do (26587)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26587;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26587, 0, 0, 0, 0, 0, 0, 0, 0, 'IT\'S PAYBACK TIME!', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26587;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26587, 0, 0, 0, 0, 'Did you get the cage key?', 0);