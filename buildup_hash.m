
%----- 

clear all;
load('features_caffe/train_out/itq_train_data_10bit_478caffe_H.mat');
dataset_root = 'features_caffe/videos/';
annotation_file_name = strcat('annotation_my.mat');
min_change = 0;
load(annotation_file_name);

[ dataset_frame_table ] = make_dataset_frame_table( dataset_root, pca_mapping, itq_rot_mat, min_change, annotation_train, mapped );
save('features_caffe/dataset_frame_table2','dataset_frame_table');

load('features_caffe/dataset_frame_table2');

[ dataset_hash_table ] = make_dataset_hash_table( dataset_frame_table );
save('features_caffe/dataset_hash_table2','dataset_hash_table');
