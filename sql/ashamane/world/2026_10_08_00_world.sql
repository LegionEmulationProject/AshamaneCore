-- Weapons of War (26571)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26571;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26571, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder buzzes with energy.>\n\nCome in, $n. Do you copy? Troteman here! Great job on getting Keeshan\'s weapons back! Now there\'s one final mission you have to run. Are you up to the challenge?', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26571;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26571, 0, 0, 0, 0, 'Did you terminate Murdunk and Homurk?', 0);