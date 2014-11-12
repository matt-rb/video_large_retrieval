    

%------------------ initialization --------------------------------------

clear all;
sub_video_kf = 10;
load_essentials;


sub_video_vectors_index=[];
sub_video_vectors = [];
sub_video_extracted_idx = 1;

for video_idx=1:size(mapped,1)
    query_no = mapped{video_idx,1};
    query_features_file = strcat(features_data_root,'videos/video',num2str(query_no),'_data.mat');
    load(query_features_file);
    [ feats, ~  ] = normalize_features( feats, mean_data );
    video_query_features = feats;
    fprintf ('%d of %d - Video No : %d  \n', video_idx,size(mapped,1), query_no);
    [ bin_mat ] = test_itq( video_query_features, itq_rot_mat, pca_mapping, false );
    candidate_frames_no = choose_keyframes(bin_mat, min_change);
    [ motion_vectors ] = calculate_motion_vectors( feats, candidate_frames_no );
    sub_vid = fix(size(candidate_frames_no,1)/sub_video_kf);
    
    for i=1:sub_vid
        start_frm= ((i-1)*sub_video_kf)+1;
        end_frm = i*sub_video_kf;
        sub_video_vector = insertrows(feats(candidate_frames_no(start_frm:end_frm,1),:), double(motion_vectors(start_frm:end_frm,:)), (1:sub_video_kf));
        sub_video_vectors = [sub_video_vectors ; sub_video_vector];
        sub_video_vectors_index = [sub_video_vectors_index ; [sub_video_extracted_idx, query_no,candidate_frames_no(start_frm,1),candidate_frames_no(end_frm,1)  ] ];
        sub_video_extracted_idx = sub_video_extracted_idx +1;
    end
    
end

save('sub_videos','sub_video_vector','sub_video_vectors_index');
