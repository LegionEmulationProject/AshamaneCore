DELETE FROM `creature` WHERE `guid` IN (10123142, 1385314, 500007, 500008);
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);