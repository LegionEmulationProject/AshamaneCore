-- Canyon Romp (26514)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26514;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26514, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder crackles and pops.>\n\nGood work, $n. I\'ve just been handed some important information. It would appear that our most hated enemy, the Blackrock orcs, have wised up...\n\n\n\nI\'ve transferred a few silver over to you for the gnome, erm, gnoll kills.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26514;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26514, 0, 0, 0, 0, 'Did you recover those collars?', 0);