-- ACLDB 735.01 world
UPDATE `updates` SET `state`='ARCHIVED',`speed`=0;
UPDATE `version` SET `db_version`='ACLDB 735.02', `cache_id`=7 LIMIT 1;
