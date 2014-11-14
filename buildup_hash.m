%% Buildup Hash-table for video key-frames stored in dataset
% This is the *first step* after extracting features from trainset videos.

%% Initialize
clear all;
load_essentials;    

%% Collect data and select video key_frames
[ dataset_frame_table, dataset_motion_table ] = make_dataset_frame_table( dataset_root, pca_mapping, itq_rot_mat, min_change, annotation_train, mapped, mean_data );
save('features_caffe/dataset_frame_motion_table','dataset_frame_table','dataset_motion_table');

%% Generate Hash-tables
% generating *key-frame hash-table* beside the *motions hash-table* between
% key-frames.
load('features_caffe/dataset_frame_motion_table');
[ dataset_index_frame ] = make_dataset_index_table( dataset_frame_table );
[ dataset_index_motion ] = make_dataset_index_table( dataset_motion_table );
[ dataset_hash_frame ] = make_hash_from_index( dataset_index_frame , dataset_frame_table );
[ dataset_hash_motion ] = make_hash_from_index( dataset_index_motion , dataset_motion_table );

%% Save Hash-tables
% save hash-tables in a single .mat file
save(dataset_hash_table_file,'dataset_hash_frame','dataset_hash_motion');

