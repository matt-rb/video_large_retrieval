function [ hash_sub_frame,hash_sub_motion ] = make_hash_table_sub(sub_video_train_flat,itq_rot_mat, pca_mapping, seprated)
motion_idx = (1:10)*2;
frame_idx = motion_idx -1;

if (seprated)
    table_sub_frame = zeros(size(sub_video_train_flat,1)*10,13);
    table_sub_motion = zeros(size(sub_video_train_flat,1)*10,13);
    fprintf('Buildup Hash Tables...\nTotall SubVideos : %d Indexing SubVideo No :  ',size(sub_video_train_flat,1));
    for idx=1:size(sub_video_train_flat,1)
        print_counter( idx );
        start_idx = ((idx-1)*10)+1;
        end_idx = idx*10;
        [ frame_bin,motion_bin,~,~ ] = extract_motions_n_frames_binaries(...
                                            sub_video_train_flat(idx,:),...
                                            itq_rot_mat, pca_mapping,...
                                            motion_idx,frame_idx,seprated);
        table_sub_frame(start_idx:end_idx,:) = [ones(10,1)*idx,(1:10)',bi2de(frame_bin,'left-msb'),frame_bin];
        table_sub_motion(start_idx:end_idx,:) = [ones(10,1)*idx,(1:10)',bi2de(motion_bin,'left-msb'),motion_bin];
    

    end
    fprintf('\n');

    save('features_caffe/dataset_frame_table_subvideo','table_sub_frame','table_sub_motion');
    [ dataset_index_frame_subvideo ] = make_dataset_index_table( table_sub_frame );
    [ dataset_index_motion_subvideo ] = make_dataset_index_table( table_sub_motion );
    [ hash_sub_frame ] = make_hash_from_index( dataset_index_frame_subvideo , table_sub_frame );
    [ hash_sub_motion ] = make_hash_from_index( dataset_index_motion_subvideo , table_sub_motion );
    save('features_caffe/dataset_hash_table_subvideo','hash_sub_frame','hash_sub_motion','dataset_index_frame_subvideo','dataset_index_motion_subvideo');
else
    
    table_sub_frame = zeros(size(sub_video_train_flat,1)*20,13);
    fprintf('Buildup Hash Tables...\nTotall SubVideos : %d Indexing SubVideo No :  ',size(sub_video_train_flat,1));
    for idx=1:size(sub_video_train_flat,1)
        print_counter( idx );
        start_idx = ((idx-1)*20)+1;
        end_idx = idx*20;
        [ frame_bin,~,~,~ ] = extract_motions_n_frames_binaries(...
                                            sub_video_train_flat(idx,:),...
                                            itq_rot_mat, pca_mapping,...
                                            motion_idx,frame_idx,seprated);
        table_sub_frame(start_idx:end_idx,:) = [ones(20,1)*idx,(1:20)',bi2de(frame_bin,'left-msb'),frame_bin];
        
    end
    fprintf('\n');
    
    save('features_caffe/dataset_frame_table_subvideo','table_sub_frame');
    [ dataset_index_frame_subvideo ] = make_dataset_index_table( table_sub_frame );
    [ hash_sub_frame ] = make_hash_from_index( dataset_index_frame_subvideo , table_sub_frame );
    hash_sub_motion = hash_sub_frame;
    save('features_caffe/dataset_hash_table_subvideo','hash_sub_frame','dataset_index_frame_subvideo');
end
end




