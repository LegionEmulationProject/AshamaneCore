-- Still Assessing the Threat (26503)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26503;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26503, 0, 0, 0, 0, 0, 0, 0, 0, 'I knew it! Looks like Yowler is behind this uprising - which is incredible, because we keep killing gnolls named Yowler. I don\'t know how many sons the original Yowler had, but it\'s got to be close to a hundred.\n\nWell, looks like we got ourselves another Yowler to kill.\n\nMagistrate Solomon must be notified.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26503;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26503, 0, 0, 0, 0, 'Did you find the gnoll plans?', 0);