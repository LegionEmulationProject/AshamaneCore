SET @OGUID := 500005;
UPDATE `gameobject` SET `PhaseId`=3249, `guid`=@OGUID+0 WHERE `guid`=1249936;
DELETE FROM `gameobject` WHERE `guid`=1250152;
