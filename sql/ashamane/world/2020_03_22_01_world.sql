/*
AshamaneCoreLegacy-Legion
cb255034ad1c6438ab2d5618ec09c329765b9d4e
2020-03-17
*/


/*!40101 SET NAMES utf8 */;


/* expansion data is loaded from `HealthScalingExpansion` column, but
HealthScalingExpansion 7 is bfa, so the core will give error. */
UPDATE `creature_template` SET `HealthScalingExpansion`=0 WHERE `HealthScalingExpansion`=7;


/*delete corrupted creature entries*/
DELETE FROM `creature_template` WHERE `entry`=142154 OR `entry`=141804 OR `entry`=141826 OR `entry`=141845 OR `entry`=141903 OR `entry`=141706 OR `entry`=141767 AND `name`="0";
DELETE FROM `creature_equip_template` WHERE `CreatureID`=142154 OR `CreatureID`=141804 OR `CreatureID`=141826 OR `CreatureID`=141845 OR `CreatureID`=141706 OR `CreatureID`=141767;
DELETE FROM `creature_template_addon` WHERE `entry`=142154 OR `entry`=141804 OR `entry`=141826 OR `entry`=141845 OR `entry`=141706 OR `entry`=141767 OR `entry`=140462;
DELETE FROM `creature_template_scaling` WHERE `Entry`=142154 OR `Entry`=141804 OR `Entry`=141826 OR `Entry`=141845 OR `Entry`=141706 OR `Entry`=141767;


/*gives error because this was added in 8.0.1.26476*/
DELETE FROM `creature_template` WHERE `entry`=140462 AND `name`="Hermf";


/*unknown items*/
UPDATE `creature_equip_template` SET `ItemID1`=0 WHERE `ItemID1`=163831 OR `ItemID1`=161486 OR `ItemID1`=128097 OR `ItemID1`=116646;
UPDATE `creature_equip_template` SET `ItemID2`=0 WHERE `ItemID2`=163832;


/*gives error because this was added in 8.0.1.27101*/
DELETE FROM `gameobject_template` WHERE `entry`=245623 AND `Data0`=200499;
DELETE FROM `gameobject_template_addon` WHERE `entry`=245623;
DELETE FROM `gameobject` WHERE `guid`=20366054 AND `id`=245623;


DELETE FROM `game_event_gameobject` WHERE `guid`=200888;
DELETE FROM `gameobject_addon` WHERE `guid`=20366054;
DELETE FROM `game_event_creature` WHERE `guid`=307680 OR `guid`=354578 OR `guid`=374011 OR `guid`=374047 OR `guid`=374319 OR `guid`=374325;


UPDATE `creature_template_addon` SET `auras`="" WHERE `auras`="122729" OR `auras`="46598" OR `auras`="61424";
UPDATE `creature_template_addon` SET `auras`="227371 206261" WHERE `entry`=114438;
UPDATE `creature_addon` SET `auras`="" WHERE `guid`=20556546 OR `guid`=40000725;


UPDATE `quest_template` SET `RewardSpell`=0 WHERE `RewardSpell`=81040;


DELETE FROM `event_scripts` WHERE `id`=11424 AND `datalong`=6781;


UPDATE `creature_template` SET `lootid`=0 WHERE `lootid`=81535 OR `lootid`=81252 OR `lootid`=75786;


UPDATE `pool_gameobject` SET `chance`=0 WHERE `pool_entry`=4303 OR `pool_entry`=4304 OR `pool_entry`=4305;


UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33194; /*non-existing or incompatible BroadcastText (ID: 138838)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32983; /*non-existing or incompatible BroadcastText (ID: 137564)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32996; /*non-existing or incompatible BroadcastText (ID: 137599)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32738; /*non-existing or incompatible BroadcastText (ID: 136656)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33005; /*non-existing or incompatible BroadcastText (ID: 137645)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32555; /*non-existing or incompatible BroadcastText (ID: 135021)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32179; /*non-existing or incompatible BroadcastText (ID: 136138)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32104; /*non-existing or incompatible BroadcastText (ID: 132082)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31631; /*non-existing or incompatible BroadcastText (ID: 129592)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31923; /*non-existing or incompatible BroadcastText (ID: 130909)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31832; /*non-existing or incompatible BroadcastText (ID: 130599)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32721; /*non-existing or incompatible BroadcastText (ID: 136541)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32453; /*non-existing or incompatible BroadcastText (ID: 135867)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32063; /*non-existing or incompatible BroadcastText (ID: 131756)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32064; /*non-existing or incompatible BroadcastText (ID: 131760)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32431; /*non-existing or incompatible BroadcastText (ID: 134033)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32430; /*non-existing or incompatible BroadcastText (ID: 134027)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32429; /*non-existing or incompatible BroadcastText (ID: 134026)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32400; /*non-existing or incompatible BroadcastText (ID: 133862)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32383; /*non-existing or incompatible BroadcastText (ID: 133809)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32380; /*non-existing or incompatible BroadcastText (ID: 133782)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32256; /*non-existing or incompatible BroadcastText (ID: 132971)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32247; /*non-existing or incompatible BroadcastText (ID: 132929)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33170; /*non-existing or incompatible BroadcastText (ID: 137831)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32234; /*non-existing or incompatible BroadcastText (ID: 132863)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32233; /*non-existing or incompatible BroadcastText (ID: 132862)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32232; /*non-existing or incompatible BroadcastText (ID: 132860)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32231; /*non-existing or incompatible BroadcastText (ID: 132856)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32255; /*non-existing or incompatible BroadcastText (ID: 132970)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32313; /*non-existing or incompatible BroadcastText (ID: 133322)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33171; /*non-existing or incompatible BroadcastText (ID: 137835)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32236; /*non-existing or incompatible BroadcastText (ID: 132866)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32237; /*non-existing or incompatible BroadcastText (ID: 132867)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32235; /*non-existing or incompatible BroadcastText (ID: 132864)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32321; /*non-existing or incompatible BroadcastText (ID: 133334)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33168; /*non-existing or incompatible BroadcastText (ID: 137809)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31640; /*non-existing or incompatible BroadcastText (ID: 129693)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31694; /*non-existing or incompatible BroadcastText (ID: 129970)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33055; /*non-existing or incompatible BroadcastText (ID: 137843)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33056; /*non-existing or incompatible BroadcastText (ID: 137934)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32798; /*non-existing or incompatible BroadcastText (ID: 136890)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32238; /*non-existing or incompatible BroadcastText (ID: 130540)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32773; /*non-existing or incompatible BroadcastText (ID: 136787)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32772; /*non-existing or incompatible BroadcastText (ID: 136781)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32778; /*non-existing or incompatible BroadcastText (ID: 136826)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32787; /*non-existing or incompatible BroadcastText (ID: 136839)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32926; /*non-existing or incompatible BroadcastText (ID: 137415)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32436; /*non-existing or incompatible BroadcastText (ID: 134071)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32946; /*non-existing or incompatible BroadcastText (ID: 137473)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33066; /*non-existing or incompatible BroadcastText (ID: 137944)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33063; /*non-existing or incompatible BroadcastText (ID: 137941)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33061; /*non-existing or incompatible BroadcastText (ID: 137939)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33062; /*non-existing or incompatible BroadcastText (ID: 137940)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33064; /*non-existing or incompatible BroadcastText (ID: 137942)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32239; /*non-existing or incompatible BroadcastText (ID: 132874)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32748; /*non-existing or incompatible BroadcastText (ID: 136701)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32160; /*non-existing or incompatible BroadcastText (ID: 132435)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32158; /*non-existing or incompatible BroadcastText (ID: 132421)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32156; /*non-existing or incompatible BroadcastText (ID: 132409)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32405; /*non-existing or incompatible BroadcastText (ID: 130540)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32692; /*non-existing or incompatible BroadcastText (ID: 136392)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32673; /*non-existing or incompatible BroadcastText (ID: 136304)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32672; /*non-existing or incompatible BroadcastText (ID: 136245)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33043; /*non-existing or incompatible BroadcastText (ID: 137846)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=33045; /*non-existing or incompatible BroadcastText (ID: 137852)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32691; /*non-existing or incompatible BroadcastText (ID: 136390)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32832; /*non-existing or incompatible BroadcastText (ID: 137081)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32671; /*non-existing or incompatible BroadcastText (ID: 136244)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31695; /*non-existing or incompatible BroadcastText (ID: 129987)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32451; /*non-existing or incompatible BroadcastText (ID: 134167)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31811; /*non-existing or incompatible BroadcastText (ID: 130540)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=32944; /*non-existing or incompatible BroadcastText (ID: 137467)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31708; /*non-existing or incompatible BroadcastText (ID: 130103)*/
UPDATE `npc_text` SET `Probability0`=0, `Probability1`=0, `Probability2`=0, `Probability3`=0, `Probability4`=0, `BroadcastTextID0`=0, `BroadcastTextID1`=0, `BroadcastTextID2`=0, `BroadcastTextID3`=0, `BroadcastTextID4`=0 WHERE `ID`=31906; /*non-existing or incompatible BroadcastText (ID: 130807)*/


DELETE FROM `creature_loot_template` WHERE `Item`=1 OR `Item`=2 OR `Item`=3 OR `Item`=4 OR `Item`=5 OR `Item`=6 OR `Item`=7 OR `Item`=8 OR `Item`=9 OR `Item`=10 OR `Item`=190069 OR `Item`=34072 OR `Item`=140022;
DELETE FROM `reference_loot_template` WHERE `Item`=107079 OR `Item`=141822 OR `Item`=134337 OR `Item`=130660 OR `Item`=122799 OR `Item`=199880 OR `Item`=141812;
UPDATE `creature_template` SET `lootid`=0 WHERE `lootid`=33118 OR `lootid`=33186 OR `lootid`=33515;
UPDATE `gameobject_template` SET `Data1`=0 WHERE `Data1`=70581 OR `Data1`=62091 OR `Data1`=64266 OR `Data1`=70565;


DELETE FROM `gameobject_loot_template` WHERE `Entry`=233107;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=240586;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241146;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241147;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241148;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241149;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241152;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241153;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241154;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241180;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241206;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241207;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241212;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241213;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241460;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241462;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241518;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241558;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241562;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241564;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241665;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241866;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241870;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241871;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241872;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241873;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=241874;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=243819;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=243820;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=243822;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=243823;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244779;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244828;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244829;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244899;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244901;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244902;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244903;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=244904;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=245171;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=249890;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=250984;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=250985;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=250987;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251007;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251008;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251713;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251714;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251716;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251723;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251761;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251762;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251764;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251772;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251776;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251780;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251782;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251792;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251820;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251854;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=251856;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=258849;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=258850;
DELETE FROM `gameobject_loot_template` WHERE `Entry`=258851;


DELETE FROM `spell_loot_template` WHERE `Entry`=263148;
DELETE FROM `spell_loot_template` WHERE `Entry`=263149;
DELETE FROM `spell_loot_template` WHERE `Entry`=263150;
DELETE FROM `spell_loot_template` WHERE `Entry`=263151;
DELETE FROM `spell_loot_template` WHERE `Entry`=263152;
DELETE FROM `spell_loot_template` WHERE `Entry`=263153;
DELETE FROM `spell_loot_template` WHERE `Entry`=263154;


DELETE FROM `reference_loot_template` WHERE `Entry`=23424;
DELETE FROM `reference_loot_template` WHERE `Entry`=23425;
DELETE FROM `reference_loot_template` WHERE `Entry`=31091;
DELETE FROM `reference_loot_template` WHERE `Entry`=31099;
DELETE FROM `reference_loot_template` WHERE `Entry`=45636;
DELETE FROM `reference_loot_template` WHERE `Entry`=263148;
DELETE FROM `reference_loot_template` WHERE `Entry`=263149;
DELETE FROM `reference_loot_template` WHERE `Entry`=263150;
DELETE FROM `reference_loot_template` WHERE `Entry`=263151;
DELETE FROM `reference_loot_template` WHERE `Entry`=263152;
DELETE FROM `reference_loot_template` WHERE `Entry`=263153;
DELETE FROM `reference_loot_template` WHERE `Entry`=263154;
DELETE FROM `reference_loot_template` WHERE `Entry`=300001;
DELETE FROM `reference_loot_template` WHERE `Entry`=300002;
DELETE FROM `reference_loot_template` WHERE `Entry`=300003;
DELETE FROM `reference_loot_template` WHERE `Entry`=300004;
DELETE FROM `reference_loot_template` WHERE `Entry`=300005;
DELETE FROM `reference_loot_template` WHERE `Entry`=300006;
DELETE FROM `reference_loot_template` WHERE `Entry`=300007;
DELETE FROM `reference_loot_template` WHERE `Entry`=300008;
DELETE FROM `reference_loot_template` WHERE `Entry`=34359;
DELETE FROM `reference_loot_template` WHERE `Entry`=34360;
DELETE FROM `reference_loot_template` WHERE `Entry`=74475;
DELETE FROM `reference_loot_template` WHERE `Entry`=74787;
DELETE FROM `reference_loot_template` WHERE `Entry`=74790;
DELETE FROM `reference_loot_template` WHERE `Entry`=75786;
DELETE FROM `reference_loot_template` WHERE `Entry`=81252;
DELETE FROM `reference_loot_template` WHERE `Entry`=81535;

