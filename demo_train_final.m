%------ clear all data and set global variables
clear all;
pca_size = 10;


collect_dataset = false;
save_mode = false;

%------ Trained ITQ Data (Include itq_bin_mat , itq_rot_mat , n_iter ,
%                                 pca_mapping , pca_size , vector_size, mean_data )


%------ COLECT DATA ------------------------------------------------------
features_data_root = 'features_caffe/';
annotation_file = 'annotation_my_more_cell.mat';
train_feature_file = 'features_caffe/features_trainset.mat';
train_feature_normal_file = 'features_caffe/features_trainset_normalized.mat';
load(annotation_file);
train_samples_no=size(annotation_train,1);
train_video_index = zeros(train_samples_no, 1);

if collect_dataset
 
    for i=1:train_samples_no
        train_video_index(i)=cell2mat(mapped((strmatch(annotation_train(i,1), mapped(:,2))),1));
    end
 
    [ train_features ] = join_fetures( strcat(features_data_root,'videos/'), train_video_index );
    if save_mode
        save(train_feature_file, 'train_features' ,'-v7.3' );
    end

    [ train_features, mean_data  ] = normalize_features( train_features );
    if save_mode
        save(train_feature_normal_file, 'train_features' ,'-v7.3' );
    end

end

%------------ TRAIN ITQ Data ---------------------------------------------------
train_data_file_name = strcat(features_data_root,'train_out/itq_train_data_',num2str(pca_size),'bit_',num2str(train_samples_no),'caffe.mat');

%------ For train Data uncomment the following code
load (train_feature_file);

n_iter = 50;
[ itq_bin_mat,itq_rot_mat,pca_mapping ] = train_itq( pca_size, n_iter, train_features );
save (train_data_file_name, 'itq_rot_mat', 'pca_mapping', 'pca_size', 'mean_data');

%------ For load a saved train Data file
load(train_data_file_name);


