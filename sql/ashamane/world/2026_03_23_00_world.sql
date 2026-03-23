-- Creature Text
SET @GROUP_ID := 0;
SET @ID := 0;
DELETE FROM `creature_text` WHERE `CreatureID` IN (77209, 79241, 79243, 79436, 79470, 79567, 79635, 79655, 79656, 79796, 82098, 82125);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(77209, @GROUP_ID+0, @ID+0, 'Thanks to you we have a terrific foothold here in Shadowmoon Valley.', 12, 0, 100, 396, 0, 0, 0, 0, 'Baros Alexston to Player'),
(79241, @GROUP_ID+0, @ID+0, 'I do hope my trust in your people is not misplaced.', 12, 0, 100, 0, 0, 45382, 0, 0, 'Prophet Velen to Player'),
(79243, @GROUP_ID+0, @ID+0, 'If you mark those trees, Shelly\'s lumberjacks will do the rest.', 12, 0, 100, 1, 0, 43525, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+1, @ID+1, 'Giant killer ravens... I have a feeling it\'s going to be a long, cold night.', 12, 0, 100, 1, 0, 43527, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+2, @ID+2, 'An excellent choice of lumber, if I do say so myself.', 12, 0, 100, 1, 0, 43526, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+3, @ID+3, 'Impressive work, commander. I know I\'ll sleep a lot better without those giant killer birds flying around.', 12, 0, 100, 1, 0, 43528, 0, 0, 'Baros Alexston to Player'),
(79243, @GROUP_ID+4, @ID+4, 'Let me know when you are ready to start construction, commander.', 12, 0, 100, 1, 0, 0, 0, 0, 'Baros Alexston to Player'),
(79436, @GROUP_ID+0, @ID+0, 'This is it, boys! Let\'s break some ground and take this world for the Alliance!', 12, 0, 100, 5, 0, 43531, 0, 0, 'Baros Alexston to Player'),
(79470, @GROUP_ID+0, @ID+0, 'Plant your banner, and claim your destiny.', 12, 0, 100, 25, 0, 44819, 0, 0, 'Vindicator Maraad to Player'),
(79470, @GROUP_ID+1, @ID+1, 'I assure you, my Prophet, the commander we\'ve chosen represents the very best of the Alliance.', 12, 0, 100, 1, 0, 44821, 0, 0, 'Vindicator Maraad to Player'),
(79567, @GROUP_ID+0, @ID+0, 'With the giant defeated we shouldn\'t have any more trouble clearing out the area.', 12, 0, 100, 1, 0, 45611, 0, 0, 'Yrel to Player'),
(79635, @GROUP_ID+0, @ID+0, 'It is good to see you, my child. My people welcome your aid, champion. Come with me.', 12, 0, 100, 396, 0, 45389, 0, 0, 'Prophet Velen to Player'),
(79635, @GROUP_ID+1, @ID+1, 'We will deal with one problem at a time. First, we must settle your people.', 12, 0, 100, 1, 0, 45391, 0, 0, 'Prophet Velen to Player'),
(79655, @GROUP_ID+0, @ID+2, 'Prophet, I must warn you: the Iron Horde intends to strike out against all who oppose him. We must prepare our defenses!', 12, 0, 100, 1, 0, 44825, 0, 0, 'Vindicator Maraad to Player'),
(79656, @GROUP_ID+0, @ID+0, 'Prophet, this hero - and many others from another world - have come to aid us.', 12, 0, 100, 1, 0, 45636, 0, 0, 'Yrel to Player'),
(79796, @GROUP_ID+0, @ID+0, 'Are you going to be okay?', 12, 0, 100, 71, 0, 0, 0, 0, 'Draenei Refugee'),
(82098, @GROUP_ID+0, @ID+0, 'Alright, come on through. Steady... Steady...', 12, 0, 100, 0, 0, 44537, 0, 0, 'Foreman Zipfizzle to Player'),
(82125, @GROUP_ID+0, @ID+0, 'I can open up a portal to Stormwind only briefly.', 12, 0, 100, 0, 0, 44990, 0, 0, 'Archmage Khadgar to Player');
