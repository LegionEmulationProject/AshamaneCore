/*
AshamaneCoreLegacy-legion rev. 2e92d50 2020-03-22 (legion branch)
*/

DELETE FROM `playercreateinfo_cast_spell` WHERE `raceMask` IN (134217728, 536870912, 268435456, 67108864);
INSERT INTO playercreateinfo_cast_spell (raceMask, classMask, spell, note) VALUES
(134217728, 4, 259084, 'Highmountain Tauren - Hunter - Great Eagle'),
(536870912, 4, 259085, 'Lightforged Draenei - Hunter - Lightforged Talbuk'),
(268435456, 4, 259086, 'Void Elf - Hunter - Shadowstalker'),
(67108864, 4, 259087, 'Nightborne - Hunter - Blue Mana Saber');

