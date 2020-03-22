/*set vendor flags for vendors*/
UPDATE `creature_template` SET `npcflag`=128 WHERE `entry` IN (92185, 98367);
UPDATE `creature` SET `npcflag`=128 WHERE `id` IN (92185, 98367);


/*groupid missing*/
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=77428 AND `Item`!=0;
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=77404 AND `Item`!=0;
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=78714 AND `Item`!=0;
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=78238 AND `Item`!=0;
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=79015 AND `Item`!=0;
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=78948 AND `Item`!=0;
UPDATE `creature_loot_template` SET `GroupId`=1 WHERE `Entry`=78491 AND `Item`!=0;


/*non-existing item (bfa)*/
DELETE FROM `npc_vendor` WHERE `item` IN (160298);


/*non-existing spells (bfa)*/
DELETE FROM `trainer_spell` WHERE `SpellId` IN (264633, 264484, 264478, 265838, 264617, 264623, 264639, 265844, 265820, 271657, 271659, 271661, 271665, 264212, 271673, 271663, 271617, 264578, 265856, 264495);
DELETE FROM `spell_target_position` WHERE `ID`=279114;


/*bfa*/
DELETE FROM `gossip_menu` WHERE `MenuId` IN (10554, 10790, 10819);
DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (10554, 10790, 10819);
DELETE FROM `gossip_menu_option_action` WHERE `MenuId` IN (10554, 10790, 10819);
DELETE FROM `gossip_menu_option_box` WHERE `MenuId` IN (10554, 10790, 10819);
DELETE FROM `gossip_menu_option_locale` WHERE `MenuId` IN (10554, 10790, 10819);
DELETE FROM `gossip_menu_option_trainer` WHERE `MenuId` IN (10554, 10790, 10819);
DELETE FROM `gossip_menu` WHERE `MenuId` IN (13714, 18575, 19769, 19867, 19907, 20728, 20746, 20974, 20985, 20989, 21004, 21013, 21049, 21058, 21059,  21067, 21072, 21075, 21144, 21163, 21208,  21238, 21239, 21240, 21241, 21242, 21243, 21244, 21245, 21247, 21253, 21291, 21312, 21315, 21323, 21380, 21423, 21451, 21454, 21456, 21457, 21462, 21505, 21519, 21709);
DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (13714, 18575, 19769, 19867, 19907, 20728, 20746, 20974, 20985, 20989, 21004, 21013, 21049, 21058, 21059,  21067, 21072, 21075, 21144, 21163, 21208,  21238, 21239, 21240, 21241, 21242, 21243, 21244, 21245, 21247, 21253, 21291, 21312, 21315, 21323, 21380, 21423, 21451, 21454, 21456, 21457, 21462, 21505, 21519, 21709);
DELETE FROM `gossip_menu_option_action` WHERE `MenuId` IN (13714, 18575, 19769, 19867, 19907, 20728, 20746, 20974, 20985, 20989, 21004, 21013, 21049, 21058, 21059,  21067, 21072, 21075, 21144, 21163, 21208,  21238, 21239, 21240, 21241, 21242, 21243, 21244, 21245, 21247, 21253, 21291, 21312, 21315, 21323, 21380, 21423, 21451, 21454, 21456, 21457, 21462, 21505, 21519, 21709);
DELETE FROM `gossip_menu_option_box` WHERE `MenuId` IN (13714, 18575, 19769, 19867, 19907, 20728, 20746, 20974, 20985, 20989, 21004, 21013, 21049, 21058, 21059,  21067, 21072, 21075, 21144, 21163, 21208,  21238, 21239, 21240, 21241, 21242, 21243, 21244, 21245, 21247, 21253, 21291, 21312, 21315, 21323, 21380, 21423, 21451, 21454, 21456, 21457, 21462, 21505, 21519, 21709);
DELETE FROM `gossip_menu_option_locale` WHERE `MenuId` IN (13714, 18575, 19769, 19867, 19907, 20728, 20746, 20974, 20985, 20989, 21004, 21013, 21049, 21058, 21059,  21067, 21072, 21075, 21144, 21163, 21208,  21238, 21239, 21240, 21241, 21242, 21243, 21244, 21245, 21247, 21253, 21291, 21312, 21315, 21323, 21380, 21423, 21451, 21454, 21456, 21457, 21462, 21505, 21519, 21709);
DELETE FROM `gossip_menu_option_trainer` WHERE `MenuId` IN (13714, 18575, 19769, 19867, 19907, 20728, 20746, 20974, 20985, 20989, 21004, 21013, 21049, 21058, 21059,  21067, 21072, 21075, 21144, 21163, 21208,  21238, 21239, 21240, 21241, 21242, 21243, 21244, 21245, 21247, 21253, 21291, 21312, 21315, 21323, 21380, 21423, 21451, 21454, 21456, 21457, 21462, 21505, 21519, 21709);


DELETE FROM `creature_formations` WHERE `leaderGUID` IN (138187, 138213, 310315);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (310334);


UPDATE `npc_vendor` SET `PlayerConditionId`=0 WHERE `PlayerConditionId` IN (12237, 12238, 12241, 12242);


UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133127 AND `item`=4404;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133127 AND `item`=4371;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133127 AND `item`=4357;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133127 AND `item`=4364;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133127 AND `item`=18647;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133127 AND `item`=22729;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133239 AND `item`=10317;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133239 AND `item`=5772;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133239 AND `item`=6270;
UPDATE `npc_vendor` SET `incrtime`=3600 WHERE `entry`=133239 AND `item`=10314;

DELETE FROM `creature_classlevelstats` WHERE `level` IN (116, 117, 118, 119, 119, 120);
insert  into `creature_classlevelstats`(`level`,`class`,`basemana`,`basearmor`,`attackpower`,`rangedattackpower`,`damage_base`,`damage_exp1`,`damage_exp2`,`damage_exp3`,`damage_exp4`,`damage_exp5`,`comment`) values 
(116,1,1,1,0,0,0,0,0,0,0,0,NULL),
(117,1,1,1,0,0,0,0,0,0,0,0,NULL),
(118,1,1,1,0,0,0,0,0,0,0,0,NULL),
(119,1,1,1,0,0,0,0,0,0,0,0,NULL),
(120,1,1,1,0,0,0,0,0,0,0,0,NULL);
