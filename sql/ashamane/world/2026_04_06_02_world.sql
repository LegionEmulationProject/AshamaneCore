DELETE FROM creature_text
WHERE CreatureID IN (42391, 42384, 42386)
AND GroupID BETWEEN 0 AND 8;


INSERT INTO creature_text
(CreatureID, GroupID, ID, Text, Type, Language, Probability, Emote, Duration, Sound, BroadcastTextId, TextRange, comment)
VALUES

-- CLUE 1
(42391,0,0,"Listen, pal. I don't want any trouble...",12,0,100,0,0,0,0,0,"clue1"),
(42384,0,0,"Listen, pal. I don't want any trouble...",12,0,100,0,0,0,0,0,"clue1"),
(42386,0,0,"Listen, pal. I don't want any trouble...",12,0,100,0,0,0,0,0,"clue1"),

-- CLUE 2
(42391,1,0,"I didn't see who killed 'm...",12,0,100,0,0,0,0,0,"clue2"),
(42384,1,0,"I didn't see who killed 'm...",12,0,100,0,0,0,0,0,"clue2"),
(42386,1,0,"I didn't see who killed 'm...",12,0,100,0,0,0,0,0,"clue2"),

-- CLUE 3
(42391,2,0,"Who killed the Furlbrows?...",12,0,100,0,0,0,0,0,"clue3"),
(42384,2,0,"Who killed the Furlbrows?...",12,0,100,0,0,0,0,0,"clue3"),
(42386,2,0,"Who killed the Furlbrows?...",12,0,100,0,0,0,0,0,"clue3"),

-- CLUE 4
(42391,3,0,"Between you, me, and the tree...",12,0,100,0,0,0,0,0,"clue4"),
(42384,3,0,"Between you, me, and the tree...",12,0,100,0,0,0,0,0,"clue4"),
(42386,3,0,"Between you, me, and the tree...",12,0,100,0,0,0,0,0,"clue4"),

-- HOSTILE
(42391,4,0,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,0,0,"hostile"),
(42384,4,0,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,0,0,"hostile"),
(42386,4,0,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,0,0,"hostile"),

-- CRAZY 1
(42391,5,0,"I wonder if it's possible to eat rocks?",12,0,100,0,0,0,0,0,"crazy1"),
(42384,5,0,"I wonder if it's possible to eat rocks?",12,0,100,0,0,0,0,0,"crazy1"),
(42386,5,0,"I wonder if it's possible to eat rocks?",12,0,100,0,0,0,0,0,"crazy1"),

-- CRAZY 2
(42391,6,0,"Looks like I found us a savory piece of dirt!",12,0,100,0,0,0,0,0,"crazy2"),
(42384,6,0,"Looks like I found us a savory piece of dirt!",12,0,100,0,0,0,0,0,"crazy2"),
(42386,6,0,"Looks like I found us a savory piece of dirt!",12,0,100,0,0,0,0,0,"crazy2"),

-- CRAZY 3
(42391,7,0,"HAHAHAH! Good one!",12,0,100,0,0,0,0,0,"crazy3"),
(42384,7,0,"HAHAHAH! Good one!",12,0,100,0,0,0,0,0,"crazy3"),
(42386,7,0,"HAHAHAH! Good one!",12,0,100,0,0,0,0,0,"crazy3"),

-- CRAZY 4
(42391,8,0,"What happened to me? I used to be king!",12,0,100,0,0,0,0,0,"crazy4"),
(42384,8,0,"What happened to me? I used to be king!",12,0,100,0,0,0,0,0,"crazy4"),
(42386,8,0,"What happened to me? I used to be king!",12,0,100,0,0,0,0,0,"crazy4");


UPDATE creature_template
SET AIName = '',
    ScriptName = 'npc_westplains_drifter'
WHERE entry IN (42386, 42391, 42386);

DELETE FROM smart_scripts
WHERE entryorguid IN (42386, 42391, 42386)
AND source_type = 0;