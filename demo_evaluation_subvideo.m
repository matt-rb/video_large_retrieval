%% -------- Initialize Evaluation of sub_videos ---------------------------

reset=0;

if reset
    clear all;
    load_essentials;
    load('sub_video_annotation.mat');
    load('sub_video_train_data.mat');
end

load_data=1;
motion_seprated_mode=false;

%% --------------------- Buildup/Load Hash table --------------------------
if load_data
    load('features_caffe/dataset_hash_table_subvideo');
else
    if motion_seprated_mode
        [ hash_sub_frame,hash_sub_motion] = make_hash_table_sub(sub_video_train_set_flat,itq_rot_mat, pca_mapping,true);
        size_hash= [1024 3];
        [ hash_sub_frame ] = make_standard_hash_table( hash_sub_frame, size_hash );
        [ hash_sub_motion ] = make_standard_hash_table( hash_sub_motion, size_hash );
        vector_size=10;
    else
        [ hash_sub_frame,~] = make_hash_table_sub(sub_video_train_set_flat,itq_rot_mat, pca_mapping,false);
        size_hash= [1024 3];
        [ hash_sub_frame ] = make_standard_hash_table( hash_sub_frame, size_hash );
        hash_sub_motion = hash_sub_frame;
        vector_size=20;
    end
    save('features_caffe/dataset_hash_table_subvideo','hash_sub_frame','hash_sub_motion');
end


%% ------------------ TEST PLAN TABLE ------------------------------------
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
   
%% -------------- START Evaluation ----------------------------------------
for test_index=1:size(sub_video_test_set_flat,1)
    motion_idx = (1:vector_size)*2;
    frame_idx = motion_idx -1;
    [ frame_bin,motion_bin,frame_feats,motion_feats ] = extract_motions_n_frames_binaries(sub_video_test_set_flat(test_index,:),itq_rot_mat, pca_mapping, motion_idx,frame_idx,motion_seprated_mode);
    
    query_keyframes =  [(1:vector_size)', bi2de(frame_bin,'left-msb')];
    [ frame_indexes, query_keyframes ] = retrieve_video( frame_feats, pca_mapping, itq_rot_mat, hash_sub_frame, min_change,false, query_keyframes); 
    [ per_video ] = sort_retrival_by_video_index( frame_indexes );
    
    [ per_video , ranked_list ] = sort_cells_by_col( per_video, 2, fales );
    per_video(:,5)=num2cell(ranked_list);
    
   
end
%% -----------------------------------------------------------------------



