-- Nidas Necklace (26508)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26508;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26508, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for finding my necklace mister $c... you are very kind!  My kitty thanks you too - isn\'t that right Effsee?', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26508;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26508, 0, 0, 0, 0, 'Hi.  I miss my necklace.  My daddy got it for me.  Daddy says that there are monsters in the lake.  Did you beat up any monsters?\nCompletion', 0);