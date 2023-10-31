-- fix startup warnings due to missing creature_equip_template entries

UPDATE `creature` SET `equipment_id` = 0 WHERE `equipment_id` = 1 AND `PhaseId` = 6666;