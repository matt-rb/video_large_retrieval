function [ dataset_key_frame_table,dataset_motion_table ] = make_dataset_frame_table( dataset_root, pca_mapping, itq_rot_mat, min_change, train_set, mapped )
% Compute key_frames and motions between key_frames from videos in dataset,
% according to the extracted frames feature vectors from each video.
%
%   input:
%       -dataset_root : root of video frame features. each video should have
%           own feature vector file stored in a mat file like
%           'video_[NO.]_data.mat'
%       -pca_mapping : PCA eigen vector [feature_dim]x[new_binary_dim]
%       -itq_rot_mat : itq routation matrix [new_binary_dim]x[new_binary_dim]
%       -min_change : minimum changes in binary vector to chose frame as a
%           key_frame.
%       -train_set : train set annotation table.each row is a set of
%           cells like:
%            __________________________________ 
%           | videoName | Frames | Act1 | Act2 |
%            ----------------------------------
%       -mapped : mapp table from dataset video name and realName like
%            ___________________________________________________
%           | videoNoOnDataset | videoName | Act1 | Act2 | Act3 |
%            ---------------------------------------------------
%
%   output:
%       -dataset_key_frame_table : extracted Key_frames vectors
%            ________________________________________________________
%           | Video_No | Frame_No | Decimal_Value | Binary_Codes |||||
%            --------------------------------------------------------
%       -dataset_motion_table : computed motion vectors
%            ________________________________________________________
%           | Video_No | Frame_No | Decimal_Value | Binary_Codes |||||
%            --------------------------------------------------------


video_no = size(train_set,1);

% Build up Key_frame table:
%  ____________________________________________________
% | Video_No | Frame_No | Decimal_Value | Binary_Codes |
%  ----------------------------------------------------
dataset_key_frame_table= [];
dataset_motion_table= [];
fprintf(1,'Extract dataset Key_frames...\nAll Videos : %d Extracting frames video No :  ',video_no);
for i=1 : video_no
    % Get correspond video No. in mapped table from video name in
    % train_set table.
    video_index = strmatch(train_set(i,1), mapped(:,2), 'exact');
    video_index = mapped{video_index,1};
    print_counter( i );
    
    % Load video feature_vecors file.
    load(strcat(dataset_root,'video',num2str(video_index),'_data.mat'));
    
    % Extract binary Codes of feature vectors for each frame.
    [ itq_bin_mat ] = test_itq( feats, itq_rot_mat, pca_mapping );
    % Calculate Key_frames
    candidate_frames_no = choose_keyframes(itq_bin_mat, min_change);
    % Calculate motions between two consequtive key_frames (Using original
    % feature vectors not binaries)
    [ motion_vectors ] = calculate_motion_vectors( feats, candidate_frames_no );
    % Extract motion vectors binaries
    [ motions_bin ] = test_itq( motion_vectors, itq_rot_mat, pca_mapping );
    
    % Collect video key_frames and motion_vectors
    selected_motion_vectors = [ones(size(candidate_frames_no,1),1)*video_index,...
                             candidate_frames_no(:,1), ...
                             bi2de(motions_bin,'left-msb'),...
                             motions_bin];
    dataset_motion_table = [dataset_motion_table ; selected_motion_vectors];                 
    selected_video_frames=  [ones(size(candidate_frames_no,1),1)*video_index,...
                             candidate_frames_no(:,1), ...
                             bi2de(itq_bin_mat(candidate_frames_no(:,1),:),'left-msb'),...
                             itq_bin_mat(candidate_frames_no(:,1),:)];
                         
    dataset_key_frame_table = [dataset_key_frame_table;selected_video_frames];
end
fprintf('\n');

end