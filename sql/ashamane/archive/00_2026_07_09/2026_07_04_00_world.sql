UPDATE `creature_template` SET `AIName`='', `scriptname`='npc_prophet_velen_79635' WHERE `entry`=79635;
UPDATE `creature_template` SET `AIName`='', `scriptname`='npc_vindicator_maraad_79655' WHERE `entry`=79655;
UPDATE `creature_template` SET `AIName`='', `scriptname`='npc_yrel_79656' WHERE `entry`=79656;
UPDATE `creature_template` SET `AIName`='', `scriptname`='npc_archmage_khadgar_79657' WHERE `entry`=79657;


DELETE FROM `spell_target_position` WHERE `ID` IN (160815, 160855, 160857, 160859);
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(160815, 0, 1116, 2296.62, 461.514, 8.77862, 5.36763, 0),
(160855, 0, 1116, 2305.88, 461.453, 7.34781, 3.19898, 0),
(160857, 0, 1116, 2306.12, 457.556, 6.89794, 2.74642, 0),
(160859, 0, 1116, 2298.34, 455.19, 8.32292, 1.7591, 0);
