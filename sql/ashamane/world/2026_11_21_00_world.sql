DELETE FROM `creature_text` WHERE `CreatureID` IN (77209, 79243, 79436, 79470, 79567, 82098);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(77209, 0, 0, 'Thanks to you we have a terrific foothold here in Shadowmoon Valley.', 12, 0, 100, 396, 0, 0, 0, 0, 'Baros Alexston to Player'),

(79243, 0, 0, 'If you mark those trees, Shelly\'s lumberjacks will do the rest.', 12, 0, 100, 1, 0, 43525, 0, 0, 'Baros Alexston to Player'),
(79243, 1, 0, 'Giant killer ravens... I have a feeling it\'s going to be a long, cold night.', 12, 0, 100, 1, 0, 43527, 0, 0, 'Baros Alexston to Player'),
(79243, 2, 0, 'An excellent choice of lumber, if I do say so myself.', 12, 0, 100, 1, 0, 43526, 0, 0, 'Baros Alexston to Player'),
(79243, 3, 0, 'Impressive work, commander. I know I\'ll sleep a lot better without those giant killer birds flying around.', 12, 0, 100, 1, 0, 43528, 0, 0, 'Baros Alexston to Player'),
(79243, 4, 0, 'Let me know when you are ready to start construction, commander.', 12, 0, 100, 1, 0, 0, 0, 0, 'Baros Alexston to Player'),

(79436, 0, 0, 'This is it, boys! Let\'s break some ground and take this world for the Alliance!', 12, 0, 100, 5, 0, 43531, 0, 0, 'Baros Alexston to Player'),

(79470, 0, 0, 'Plant your banner, and claim your destiny.', 12, 0, 100, 25, 0, 44819, 0, 0, 'Vindicator Maraad to Player'),
(79470, 1, 0, 'I assure you, my Prophet, the commander we\'ve chosen represents the very best of the Alliance.', 12, 0, 100, 1, 0, 44821, 0, 0, 'Vindicator Maraad to Player'),

(79567, 0, 0, 'With the giant defeated we shouldn\'t have any more trouble clearing out the area.', 12, 0, 100, 1, 0, 45611, 0, 0, 'Yrel to Player'),

(82098, 0, 0, 'Alright, come on through. Steady... Steady...', 12, 0, 100, 0, 0, 44537, 0, 0, 'Foreman Zipfizzle to Player');
