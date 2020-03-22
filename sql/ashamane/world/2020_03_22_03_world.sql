DELETE FROM `trinity_string` WHERE `entry` IN (84, 85, 86, 1031, 11017, 11018, 11019, 11020, 11021);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
('84','Size: %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('85','Faction: %u Flags: %u',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('86','Model dimensions from center: Max X %f Y %f Z %f Min X %f Y %f Z %f',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('1031','An account password can NOT be longer than 16 characters (client limit). The account was NOT created.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('11017','Server shutdown delayed to %d seconds as other users are still connected. Specify \'force\' to override.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('11018','Server shutdown scheduled for T+%d seconds was successfully cancelled.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('11019','You changed %s of %s to %d/%d.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('11020','%s changed your %s to %d/%d.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
('11021','Invalid power name.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
