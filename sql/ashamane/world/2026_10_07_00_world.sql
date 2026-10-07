-- Tuning the Gnomecorder (26512)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26512;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26512, 0, 0, 0, 0, 0, 0, 0, 0, '<The gnomecorder crackles and pops.>\n\nCan you hear me, $n? Is this thing on? Ah, yes, I see you there now.\n\nLet\'s get to work!', 0);