-- The Collector
DELETE FROM quest_poi WHERE QuestID=123;
DELETE FROM quest_poi_points WHERE QuestID=123;
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) SELECT 123,0,0,0,ID,ObjectID,0,30,0,0,1,0,0,0,0,22908 FROM quest_objectives WHERE QuestID=123 AND `Order`=0 LIMIT 1;
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (123,0,0,-9468,-1306,22908);
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) SELECT 123,1,1,-1,0,ObjectID,0,30,0,0,1,0,0,0,0,22908 FROM quest_objectives WHERE QuestID=123 AND `Order`=0 LIMIT 1;
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (123,1,0,-9468,-1306,22908);