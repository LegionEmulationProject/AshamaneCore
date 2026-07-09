DELETE FROM quest_poi WHERE QuestID=106;
DELETE FROM quest_poi_points WHERE QuestID=106;

INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) VALUES (106,0,0,0,252573,0,0,12,0,0,0,0,0,0,0,0);

INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (106,0,0,-9930,500,0);