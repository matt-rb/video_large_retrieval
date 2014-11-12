

pca_size = 10;
min_change = 0;


features_data_root = 'features_caffe/';
dataset_root = 'features_caffe/videos/';
dataset_hash_table_file= 'features_caffe/hash_tables_sub/dataset_hash_table_1';
train_data_file_name = strcat(features_data_root,'train_out/itq_train_data_',num2str(pca_size),'bit_411caffe_1.mat');
annotation_file_name = strcat('annotation_my_more_cell.mat');



load(annotation_file_name);
load(train_data_file_name);