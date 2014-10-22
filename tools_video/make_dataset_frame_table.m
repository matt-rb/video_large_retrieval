function [ dataset_frame_table,dataset_motion_table ] = make_dataset_frame_table( dataset_root, pca_mapping, itq_rot_mat, min_change, train_set, mapped )

%listing = dir(strcat(dataset_root,'*.mat'));
%listing = extractfield(listing,'name');
video_no = size(train_set,1);

% Build Frame table  Video_No | Frame_No | Decimal_Value | Binary_Codes
dataset_frame_table= [];
dataset_motion_table= [];
fprintf(1,'Extract dataset Key_frames...\nAll Videos : %d Extracting frames video No :  ',video_no);
for i=1 : video_no
    video_index = strmatch(train_set.videoName{i}, mapped.videoName, 'exact');
    video_index = mapped.videoNo(video_index);
    print_counter( i );
    load(strcat(dataset_root,'video',num2str(video_index),'_data.mat'));
    [ itq_bin_mat ] = test_itq( feats, itq_rot_mat, pca_mapping );
    bit_changes = claculate_bit_changes( itq_bin_mat );
    candidate_frames_no = choose_candidate(bit_changes, min_change);
    [ motion_vectors ] = clculate_motion_vectors( feats, candidate_frames_no );
    [ motions_bin ] = test_itq( motion_vectors, itq_rot_mat, pca_mapping );
    selected_motion_vectors = [ones(size(candidate_frames_no,1),1)*video_index,...
                             candidate_frames_no(:,1), ...
                             bi2de(motions_bin),...
                             motions_bin];
    dataset_motion_table = [dataset_motion_table ; selected_motion_vectors];                 
    selected_video_frames=  [ones(size(candidate_frames_no,1),1)*video_index,...
                             candidate_frames_no(:,1), ...
                             bi2de(itq_bin_mat(candidate_frames_no(:,1),:)),...
                             itq_bin_mat(candidate_frames_no(:,1),:)];
                         
    dataset_frame_table = [dataset_frame_table;selected_video_frames];
end
fprintf('\n');

end