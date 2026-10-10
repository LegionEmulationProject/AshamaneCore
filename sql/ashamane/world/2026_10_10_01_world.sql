-- They Drew First Blood (26607)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26607;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26607, 0, 0, 0, 0, 0, 0, 0, 0, '<Keeshan takes the bundle from you and opens it.>\n\nMy bow... and knife! Where did you...\n\nJade\'s amulet... My darling Jade.\n\n<Keeshan picks up his red headband.>\n\nWe got orcs to kill.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26607;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26607, 0, 0, 0, 0, 'You again?', 0);