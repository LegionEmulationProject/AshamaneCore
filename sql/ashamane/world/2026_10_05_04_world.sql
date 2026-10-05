-- We Must Prepare! (26510)
DELETE FROM `quest_request_items` WHERE `ID` = 26510;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26510, 0, 0, 0, 0, 'Have you recovered the gnomecorder?', 0);
  
DELETE FROM `quest_offer_reward` WHERE `ID` = 26510;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26510, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent! Let me make a few adjustments here and we should be good to go.', 0);