SET @OGUID := 500002;
UPDATE `gameobject` SET `PhaseId`=3251, `guid`=@OGUID+0 WHERE `guid`=1249915;
DELETE FROM `gameobject` WHERE `guid`=1250126;