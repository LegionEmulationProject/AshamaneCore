-- Add gossip flag to recruter lee
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry`=107934;