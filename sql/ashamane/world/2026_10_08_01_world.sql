-- Surveying Equipment (26569)
DELETE FROM `quest_offer_reward` WHERE `ID` = 26569;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(26569, 0, 0, 0, 0, 0, 0, 0, 0, 'Fantastic work, $n! These will come in handy for our next project, the Lakeshire SUPER BRIDGE, meant to traverse the length of Lake Everstill. It should be done in 20 or so years. Give or take a decade or two.', 0);

DELETE FROM `quest_request_items` WHERE `ID` = 26569;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(26569, 0, 0, 0, 0, 'Did you recover the spyglasses?', 0);