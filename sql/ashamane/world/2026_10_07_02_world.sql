-- They've Wised Up (26544)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26544;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26544, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder buzzes and whirs.>\n\nJust put the missive in the little compartment and I\'ll read it. I am fluent in orcish.\n\n<You hear a distraught yell in the background.>\n\nIt looks like these orcs are here under the direct command of Yowler. That means Yowler must have the orc invasion plan.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26544;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26544, 0, 0, 0, 0, 'What have you found out?', 0);