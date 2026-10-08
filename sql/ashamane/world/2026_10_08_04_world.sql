-- Jorgensen (26560)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26560;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26560, 0, 0, 0, 0, 0, 0, 0, 0, 'I know where they\'re holding Krakauer and Danforth. We gotta hurry. They were prepping those two for a sacrifice!', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26560;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26560, 0, 0, 0, 0, 'Messner! Damn, it\'s good to see a friendly face. Get me out of here!', 0);