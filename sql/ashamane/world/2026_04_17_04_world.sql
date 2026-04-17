SET @OGUID := 500006;
UPDATE `gameobject` SET `PhaseId`=3250, `guid`=@OGUID+0 WHERE `guid`=1249923;
DELETE FROM `gameobject` WHERE `guid`=1250132;
