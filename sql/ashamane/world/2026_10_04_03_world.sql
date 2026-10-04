-- Lake Everstill Clean Up (26511)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26511;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26511, 0, 0, 0, 0, 0, 0, 0, 0, 'That ought to teach those murlocs a lesson. Hopefully the next time they decide to raid our town they\'ll think twice.\n\nWe both know that won\'t happen.', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26511;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26511, 0, 0, 0, 0, 'Have you killed all the murlocs?', 0);