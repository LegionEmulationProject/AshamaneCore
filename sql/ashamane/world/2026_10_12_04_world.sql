-- The Dark Tower (26693)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26693;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26693, 0, 0, 0, 0, 0, 0, 0, 0, '<Keeshan comes in over the Bravo Company field kit.>\n\nNow that the easy part is over, it\'s time for phase two.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26693;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26693, 0, 0, 0, 0, 'I hear you loud and clear, $n.', 0);