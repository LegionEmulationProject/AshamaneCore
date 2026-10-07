-- Like a Fart in the Wind (26513)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26513;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26513, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you, citizen. Without you, we would have starved or worse, been forced to go out and get food for ourselves.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26513;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26513, 0, 0, 0, 0, 'Did you recover the supplies?', 0);