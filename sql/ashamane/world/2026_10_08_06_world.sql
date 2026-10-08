-- And Last But Not Least... Danforth (2656)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26562;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26562, 0, 0, 0, 0, 0, 0, 0, 0, 'About damn time you sissies showed up. My arms were gettin\' tired.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26562;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26562, 0, 0, 0, 0, 'Well look at that! The team\'s all here... everyone but Keeshan.', 0);