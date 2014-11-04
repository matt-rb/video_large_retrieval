function [ frame_indexes, query_keyframes ] = retrieve_video( video_query_features, pca_mapping, itq_rot_mat, hash_table, min_change,retrieve_by_motion, query_keyframes)
% get an video query feature vectors and retrieve similar videos from
% dataset.
%
%   input:
%       -video_query_features : extracted feature vectors of query video.
%       -pca_mapping , itq_rot_mat : ITQ train data.
%       -hash_table: Cellarray, Video hash table 
%           [ [hash_code] , [video_nos, frame_nos] , [binaries] ]
%       -min_change : minimum number of bit change to consider as key_frame
%       -retrieve_by_motion : to retrieve based on motion_vectors set
%           retrieve_by_motion=true
%       -query_keyframes: if there is no need to select key_frames, you can
%           pass quey video key_frames by this parameter.
%           [ Key_frame_index , numberOfBitChanges ]
%
%   output:
%       -frame_indexes: a vector contain query key_frames indexes and
%           correspond videos key_frames in dataset.
%           [ Key_frame_index , [ videos_Nos, frame_indexes] ]
%       -query_keyframes: extracted key_frames from query video
%           [ Key_frame_index , numberOfBitChanges ]



% Extract Binary vectors and key_frames of given query video
if not(exist('query_keyframes','var'))
    [ bin_mat_q ] = test_itq( video_query_features, itq_rot_mat, pca_mapping );
    candidate_frames_no_q = choose_keyframes( bin_mat_q, min_change );
    if exist('retrieve_by_motion','var') && retrieve_by_motion
        [ motion_vectors ] = calculate_motion_vectors( video_query_features, candidate_frames_no_q );
        [ motions_bin ] = test_itq( motion_vectors, itq_rot_mat, pca_mapping );
        query_keyframes=  [candidate_frames_no_q(:,1), bi2de(motions_bin)];
    else
        query_keyframes=  [candidate_frames_no_q(:,1), bi2de(bin_mat_q(candidate_frames_no_q(:,1),:))];  
    end
end

% Get correspond video key_frames from dataset with each key_frame in the
% query using hash_table data
frame_indexes = [num2cell(query_keyframes(:,1)), hash_table(query_keyframes(:,2)+1,2)];
end

