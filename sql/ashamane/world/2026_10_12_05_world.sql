-- The Grand Magus Doane (26694)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26694;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26694, 0, 0, 0, 0, 0, 0, 0, 0, 'He teleported away? Mentioned Darkblaze? What the hell is going on here.\n\nLooks like it\'s time to strap in and finish this nonsense.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26694;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26694, 0, 0, 0, 0, 'I hear you loud and clear, $n.', 0);