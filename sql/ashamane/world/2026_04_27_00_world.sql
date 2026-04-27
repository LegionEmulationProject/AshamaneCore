UPDATE `scenarios` SET `scenario_A`=786, `scenario_h`=1189 WHERE `map`=1460;

DELETE FROM `instance_template` WHERE `map`=1460;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`, `insideResurrection`) 
VALUES (1460, 0, 'instance_broken_shore_scenario', 0, 1);
