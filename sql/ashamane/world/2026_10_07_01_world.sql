-- Yowler Must Die! (26545)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26545;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26545, 0, 0, 0, 0, 0, 0, 0, 0, '<Magistrate Solomon takes the plans from you and begins reading.>\n\nShadowhide army!? Damn those orcs to hell! These invasion plans speak of a massive build up of orcish and gnoll forces in the east. Looks like Gath\'Ilzogg, the Blackrock general, is preparing to march his armies across Lakeshire and attack Stormwind directly!', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26545;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26545, 0, 0, 0, 0, 'Do you have the Blackrock invasion plans?', 0);