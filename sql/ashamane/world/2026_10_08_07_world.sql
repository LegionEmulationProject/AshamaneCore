-- His Heart Must Be In It (26573)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26573;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26573, 0, 0, 0, 0, 0, 0, 0, 0, 'I hope with these items and with his crew all rescued he\'ll have a change of heart. We can\'t do this without Keeshan.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26573;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26573, 0, 0, 0, 0, 'Did you locate the headband and amulet?', 0);