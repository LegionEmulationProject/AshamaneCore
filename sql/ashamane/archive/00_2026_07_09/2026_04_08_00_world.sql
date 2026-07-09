-- =========================================
-- Brother Paxton (951) CLEAN WAYPOINT
-- =========================================

SET @CGUID := 177921;
SET @PATH := 95100;

-- =========================================
-- 1. CLEAN OLD DATA
-- =========================================

DELETE FROM creature_addon WHERE guid = @CGUID;
DELETE FROM waypoint_data WHERE id = @PATH;

INSERT INTO waypoint_data (id, point, position_x, position_y, position_z)
VALUES
(@PATH, 1, -8823.3896, -147.5188, 80.7598),
(@PATH, 2, -8819.9200, -149.5330, 81.1093),
(@PATH, 3, -8816.4660, -153.0781, 81.5844),
(@PATH, 4, -8814.2940, -157.2969, 81.6237),
(@PATH, 5, -8816.4660, -153.0781, 81.5844),
(@PATH, 6, -8819.9200, -149.5330, 81.1093);

-- =========================================
-- 3. LINK PATH TO CREATURE
-- =========================================

REPLACE INTO creature_addon (guid, path_id)
VALUES
(@CGUID, @PATH);

-- =========================================
-- 4. ENABLE WAYPOINT MOVEMENT
-- =========================================

UPDATE creature
SET MovementType = 2
WHERE guid = @CGUID;