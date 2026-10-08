-- Krakauer (26561)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26561;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26561, 0, 0, 0, 0, 0, 0, 0, 0, 'Wha... Where am I? What happened? Messner? Jorgensen?\n\nOH MY GOSH! We have to get to Danforth! It might already be too late!', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26561;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26561, 0, 0, 0, 0, '<Krakauer groans.>', 0);