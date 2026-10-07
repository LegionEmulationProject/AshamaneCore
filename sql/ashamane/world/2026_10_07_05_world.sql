-- He Who Controls the Ettins (26519)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26519;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26519, 0, 0, 0, 0, 0, 0, 0, 0, '<The orb hisses as you touch it.>', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26519;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26519, 0, 0, 0, 0, '<The orb emanates powerful magic.>', 0);