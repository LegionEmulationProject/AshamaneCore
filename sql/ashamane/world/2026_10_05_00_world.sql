-- Franks and Beans (26506)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26506;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26506, 0, 0, 0, 0, 0, 0, 0, 0, 'PERFECT! I\'ll put these in the pot right away. Dinner should be ready in a few hours.\n\nThank you, darling!', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26506;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26506, 0, 0, 0, 0, 'Have you gotten my ingredients?', 0);