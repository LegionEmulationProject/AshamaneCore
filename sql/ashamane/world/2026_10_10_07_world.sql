-- Bravo Company Field Kit: Camouflage (26636)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26636;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26636, 0, 0, 0, 0, 0, 0, 0, 0, 'Nice job, rookie. I\'m gonna go ahead and put the camo in the box. We should be ready soon.', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26636;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26636, 0, 0, 0, 0, 'Leaves and poop - that\'s what I need.', 0);