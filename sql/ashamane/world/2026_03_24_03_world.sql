-- cleanup startup logs 2

DELETE FROM `script_waypoint` WHERE `entry` IN (79219, 79218, 79206);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21058 AND `SourceEntry`=5;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21072 AND `SourceEntry` IN (5, 6, 7);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21253 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=21312 AND `SourceEntry`=0;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=10 AND `SourceGroup`=34379 AND `SourceEntry` IN (50453, 50452);
