%% ------------------ initialization --------------------------------------

clear all;
load_essentials;
%load('features_caffe/dataset_frame_table_temp.mat');
load(dataset_hash_table_file);

%% ------------------ TEST PLAN --------------------------------------------
% Build test plan overall table structure
test_parameter_cols.Category = 1;
test_parameter_cols.Percision = 40;
test_parameter_cols.Recall= 40;
test_parameter_cols.Count= 1;
test_parameter_cols.AVG= 1;

test_parameter_rows.Category = {'SitUp', 'GetOutCar', 'StandUp', 'AnswerPhone'...
                               , 'Kiss', 'HugPerson', 'SitDown', 'HandShake'};
test_parameter_rows.Percision = 0;
test_parameter_rows.Recall = 0;
test_parameter_rows.Count= 0;
test_parameter_rows.AVG= 0;
                           
[ sum_table ] = build_testPlan_table( test_parameter_cols,test_parameter_rows );

   

%% ---------- START Evaluation --------------------------------------------
for test_index=1:size(annotation_test,1)
%% Select test samples from dataset 
%  extract key frames and bianreies and retrieve correspond videos from 
%  dataset train samples.

    % fetch video test sample index and feature_vector file
    inx= strmatch(annotation_test(test_index,1), mapped(:,2), 'exact');
    query_no = mapped{inx,1};
    query_features_file = strcat(features_data_root,'videos/video',num2str(query_no),'_data.mat');
    load(query_features_file);
    % Select action start_frame and end_frame from mapped table
    start_frm = str2double(mapped{inx,5} (1:strfind(mapped{inx,5},'-')-1));
    end_frm = str2double(mapped{inx,5} (strfind(mapped{inx,5},'-')+1:end));
    if end_frm> size(feats,1)
        end_frm = size(feats,1);
    end
    video_query_features = feats(start_frm:end_frm,:);
    [video_query_features, ~] = normalize_features( video_query_features );

    % Retrieve query video and correspond motion_vectors
    fprintf ('%d of %d - Video No : %d \t Category1: %s  \t Category2: %s \n', test_index,size(annotation_test,1), query_no, char(mapped{inx,3}),char(mapped{inx,4}));
    max_return = 400;
    [ per_video ] = ranked_retrieve( video_query_features, pca_mapping,itq_rot_mat, dataset_hash_frame, min_change, mapped, max_return,  false );
    [ per_video_motion ] = ranked_retrieve( video_query_features, pca_mapping,itq_rot_mat, dataset_hash_motion, min_change, mapped, max_return, true );
    
    for p_idx=1:size(per_video,1)
    %% Calculate sum of rankes from motions and frames vector
        m_idx = find(cell2mat(per_video_motion(:,1))==cell2mat(per_video(p_idx,1)));
        if size(m_idx,1)>0
            per_video(p_idx,5) = num2cell(cellfun(@plus,per_video(p_idx,5),per_video_motion(m_idx,5)));
        end
    end
    % sort retrieved videos by calculated rank
    [ per_video , ~ ] = sort_cells_by_col( per_video, 5 );
    
    %% --------- Buid Summary Table of Categories " Act1 | GroupCount "
    grp_cats = grpstats(cell2dataset(annotation_train(:,3)),1);
    grp_cats.Properties.VarNames{1} = 'Act';
    grp_cats2 = grpstats(cell2dataset(annotation_train(:,4)),1);
    grp_cats2.Properties.VarNames{1} = 'Act2';
    for i=1:size(grp_cats2,1)
        idx_cat = strmatch(grp_cats2.Act2(i),grp_cats.Act,'exact');
        if idx_cat >0
            grp_cats.GroupCount(idx_cat) = grp_cats.GroupCount(idx_cat) + grp_cats2.GroupCount(i);
        else
            grp_cats.Act(size(grp_cats,1)+1) = grp_cats2.Act2(i);
            grp_cats.GroupCount(size(grp_cats,1)+1) = grp_cats2.GroupCount(i); 
        end       
    end
    
    idx_cat = strmatch(mapped{inx,3},sum_table.Category,'exact');
    sum_table.Count(idx_cat) = sum_table.Count(idx_cat) + 1;
    if length(char(mapped{inx,4}))>1
        idx_cat2 = strmatch(mapped{inx,4},sum_table.Category,'exact');
        sum_table.Count(idx_cat2) = sum_table.Count(idx_cat2) + 1;
    end
    
    for pers=1:40
        if pers*10 > size(per_video,1)
            continue;
        end
        if length(char(mapped{inx,3}))>1
            [ precision, recall ] = precision_recall( per_video, pers*10, mapped{inx,3}, mapped{inx,4} , grp_cats );
            fprintf ('%d - Percision : %f  - recall: %f \n', pers*10, precision, recall);
            sum_table.(strcat('Percision',num2str(pers)))(idx_cat) = sum_table.(strcat('Percision',num2str(pers)))(idx_cat) + precision;
            sum_table.(strcat('Recall',num2str(pers)))(idx_cat) = sum_table.(strcat('Recall',num2str(pers)))(idx_cat) + recall;
        end
        if length(char(mapped{inx,4}))>1
            sum_table.(strcat('Percision',num2str(pers)))(idx_cat2) = sum_table.(strcat('Percision',num2str(pers)))(idx_cat2) + precision;
            sum_table.(strcat('Recall',num2str(pers)))(idx_cat2) = sum_table.(strcat('Recall',num2str(pers)))(idx_cat2) + recall; 
        end
    end
    
end

for i=1:8
    for pers=1:40
        sum_table.(strcat('Percision',num2str(pers)))(i) = sum_table.(strcat('Percision',num2str(pers)))(i)/sum_table.Count(i);
        sum_table.(strcat('Recall',num2str(pers)))(i) = sum_table.(strcat('Recall',num2str(pers)))(i)/sum_table.Count(i);
    end
end