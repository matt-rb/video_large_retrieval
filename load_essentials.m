
itq_data_root = 'features_caffe/';
dataset_root = 'features_caffe/videos/';

train_data_file_name = strcat(itq_data_root,'train_out/itq_train_data_10bit_478caffe_H.mat');
annotation_file_name = strcat('annotation_my_more_cell.mat');
min_change = 0;

load(annotation_file_name);
load(train_data_file_name);