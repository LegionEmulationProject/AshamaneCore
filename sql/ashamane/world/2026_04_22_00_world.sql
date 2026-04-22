UPDATE creature_template
SET AIName = 'SmartAI'
WHERE entry = 3273;

DELETE FROM smart_scripts
WHERE entryorguid = 3273
  AND source_type = 0
  AND id = 0;

INSERT INTO smart_scripts
(entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags,
 event_param1, event_param2, event_param3, event_param4, event_param5, event_param_string,
 action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6,
 target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment)
VALUES
(3273,0,0,0,4,0,100,1,0,0,0,0,0,'',11,6535,16,0,0,0,0,1,0,0,0,0,0,0,0,'Kolkar Stormer - On Aggro - Cast Lightning Cloud on self');


DELETE FROM quest_poi WHERE QuestID=106;
DELETE FROM quest_poi_points WHERE QuestID=106;
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) VALUES (106,0,0,0,252573,1208,0,12,0,0,1,0,0,0,0,22908);
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (106,0,0,-9930,500,22908);
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) VALUES (106,1,1,-1,0,1208,0,12,0,0,1,0,0,0,0,22908);
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (106,1,0,-9930,500,22908);

DELETE FROM quest_poi WHERE QuestID=353;
DELETE FROM quest_poi_points WHERE QuestID=353;
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) VALUES (353,0,0,0,253206,2806,0,35,0,0,1,0,0,0,0,22908);
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (353,0,0,-4818,-2696,22908);
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,WorldMapAreaId,Floor,Priority,Flags,WorldEffectID,PlayerConditionID,SpawnTrackingID,AlwaysAllowMergingBlobs,VerifiedBuild) VALUES (353,1,1,-1,0,2806,0,35,0,0,1,0,0,0,0,22908);
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,VerifiedBuild) VALUES (353,1,0,-4818,-2696,22908);

DELETE FROM spell_target_position WHERE ID = 197107;

INSERT INTO spell_target_position
(ID, EffectIndex, MapID, PositionX, PositionY, PositionZ, Orientation, VerifiedBuild)
VALUES
(197107, 0, 0, -8998.14, 861.254, 29.6206, 0, 22566);