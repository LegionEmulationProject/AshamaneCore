-- fix wordserver startup warnings
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (49340, 98367, 98367, 107997);
UPDATE `creature_template` SET `npcflag`=`npcflag`|32 WHERE `entry` = 35807;