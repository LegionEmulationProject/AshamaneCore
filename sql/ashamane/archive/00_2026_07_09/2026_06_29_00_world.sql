DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `gameobject_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);

UPDATE `creature_template` SET `ScriptName`='npc_archmage_khadgar_103660' WHERE `entry`=103660;
UPDATE `quest_template_addon` SET `ScriptName`='quest_finding_a_foothold' WHERE `id`=34582;
UPDATE `quest_template_addon` SET `ScriptName`='quest_down_to_azsuna' WHERE `id`=41220;
UPDATE `creature_template` SET AIName = '', scriptname = 'npc_gilnean_crow' WHERE entry=50260;
UPDATE `creature_template` SET `ScriptName` = 'npc_curator_astral_flare' WHERE `entry` = 17096;
UPDATE `creature_template` SET `ScriptName` = 'npc_curator_astral_flare' WHERE `entry` = 19781;
UPDATE `creature_template` SET `ScriptName` = 'npc_curator_astral_flare' WHERE `entry` = 19782;
UPDATE `creature_template` SET `ScriptName` = 'npc_curator_astral_flare' WHERE `entry` = 19783;
