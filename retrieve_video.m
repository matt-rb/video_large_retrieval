function [ frame_indexes, query_keyframes ] = retrieve_video( video_query_features, pca_mapping, itq_rot_mat, hash_table, min_change,query_keyframes )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Extract Query Binary vectors and key_frames
frame_indexes = [];

if not(exist('query_keyframes','var'))
[ bin_mat_q ] = test_itq( video_query_features, itq_rot_mat, pca_mapping );
bit_changes_q = claculate_bit_changes( bin_mat_q );
candidate_frames_no_q = choose_candidate(bit_changes_q, min_change);
query_keyframes=  [candidate_frames_no_q(:,1), bi2de(bin_mat_q(candidate_frames_no_q(:,1),:))];
end

for i=1:size(query_keyframes,1)

frame_indexes = [frame_indexes ; [ query_keyframes(i,1) ,hash_table(query_keyframes(i,2)+1,2)]];
end

end

