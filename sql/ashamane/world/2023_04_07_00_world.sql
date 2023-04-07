-- Remove old warrior class orderhall spawns

DELETE FROM `creature` WHERE `map` = 1479;
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);

DELETE FROM `gameobject` WHERE `map` = 1479;
DELETE FROM `gameoejct_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);