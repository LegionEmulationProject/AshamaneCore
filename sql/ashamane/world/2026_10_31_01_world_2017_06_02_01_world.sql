--
UPDATE `creature_template` SET `AIName`='NullCreatureAI' WHERE `AIName`='NullAI';
UPDATE `creature` SET `wander_distance`=5 WHERE `guid` IN (51879,51914);
