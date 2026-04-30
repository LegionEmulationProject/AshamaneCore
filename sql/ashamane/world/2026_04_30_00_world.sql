UPDATE `quest_template_addon` SET `ScriptName`='quest_the_dreadlords_prize' WHERE `id`=41036;

DELETE FROM `smart_scripts` WHERE `entryorguid`=41036;

DELETE FROM `spell_target_position` WHERE `ID`=223059;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES 
(223059, 0, 1220, -843.19965, 4431.2007, 742.70355, 4.810614, 0);

