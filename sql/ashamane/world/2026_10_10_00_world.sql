-- Unspeakable Atrocities (26640)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26640;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26640, 0, 0, 0, 0, 0, 0, 0, 0, '<Keeshan reads the report.>\n\nDAMN IT! This just got complicated. We\'ve got prisoners of war to rescue before we can blow up the valley. Not to mention the orcs have black dragons on their side.\n\nAre you ready, $n?', 0);
  
DELETE FROM `quest_request_items` WHERE `ID` = 26640;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26640, 0, 0, 0, 0, 'They got Brubaker?', 0);