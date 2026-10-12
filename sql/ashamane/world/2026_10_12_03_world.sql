-- Shadowhide Extinction (26692) - Sets quest completion description.
DELETE FROM `quest_offer_reward` WHERE `ID` = 26692;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26692, 0, 0, 0, 0, 0, 0, 0, 0, 'We\'re closing in on the Blackrock high command. There\'s nowhere left for those dogs to run.', 0);