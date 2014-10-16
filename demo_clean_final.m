%------ clear all data and set global variables
clear all;
frame_name = 'frm';
min_change = 1;

%------ Trained ITQ Data (Include itq_bin_mat , itq_rot_mat , n_iter ,
%                                 pca_mapping , pca_size , vector_size )


%------ COLECT DATA ------------------------------------------------------
itq_data_root = 'features_caffe/videos/';
annotation_file = 'annotation_my.mat';
train_feature_file = 'features_caffe/features_trainset.mat';

load(annotation_file);
% train_video_index = zeros(size(annotation_train,1), 1);
% 
% for i=1:size(annotation_train,1)
%     train_video_index(i)=mapped.videoNo(strmatch(annotation_train.videoName{i}, mapped.videoName));
% end
% 
% [ temp_features ] = join_fetures( itq_data_root, train_video_index );
% save(train_feature_file, 'temp_features' );



%------------ TRAIN ITQ Data ---------------------------------------------------
train_data_file_name = strcat(itq_data_root,'train/itq_train_data_10bit_402caffe.mat');

%------ For train Data uncomment the following code
load (train_feature_file);
vector_size = 4096;
pca_size = 10;
n_iter = 50;
load_from_file = true;
train_features_file='';
[ itq_bin_mat,itq_rot_mat,pca_mapping ] = train_itq( pca_size, n_iter, temp_features );
save (train_data_file_name, 'itq_bin_mat', 'itq_rot_mat', 'n_iter', 'pca_mapping', 'pca_size', 'vector_size');

%------ For load a saved train Data file
load(train_data_file_name);


