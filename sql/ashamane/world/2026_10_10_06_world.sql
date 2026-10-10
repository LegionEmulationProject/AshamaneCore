-- Bravo Company Field Kit Chloroform (26637)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26637;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26637, 0, 0, 0, 0, 0, 0, 0, 0, 'Perfect. Those orcs won\'t know what hit \'em - literally. I\'ll need a few minutes to get these in working order and then I\'ll put them in the Bravo Company field kit.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26637;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26637, 0, 0, 0, 0, 'Did you recover the glands?', 0);