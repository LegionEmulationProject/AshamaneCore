-- WANTED: Redridge Gnolls (26504) - Sets quest completion description.
DELETE FROM `quest_offer_reward` WHERE `ID` = 26504;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26504, 0, 0, 0, 0, 0, 0, 0, 0, 'A job well done deserves a reward, wouldn\'t you say?\n\nDon\'t spend this all in one place, $c. Better to spread it around, if you catch my drift.', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26504;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26504, 0, 0, 0, 0, 'Come to collect on a bounty?', 0);