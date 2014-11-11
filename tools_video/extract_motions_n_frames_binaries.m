function [ frame_bin,motion_bin,frame_feats,motion_feats ] = extract_motions_n_frames_binaries(sub_video_flat,itq_rot_mat, pca_mapping, motion_idx,frame_idx,seprated)

if (nargin<5)
  motion_idx = (1:10)*2;
  frame_idx = motion_idx -1;
end
if (seprated)
    sub_video_flat = reshape(sub_video_flat,20,4096);
    [ itq_bin_mat ] = test_itq( sub_video_flat, itq_rot_mat, pca_mapping, false );
    frame_bin = itq_bin_mat(frame_idx,:);
    motion_bin = itq_bin_mat(motion_idx,:);
    frame_feats= sub_video_flat(frame_idx,:);
    motion_feats= sub_video_flat(motion_idx,:);
else
    sub_video_flat = reshape(sub_video_flat,20,4096);
    [ itq_bin_mat ] = test_itq( sub_video_flat, itq_rot_mat, pca_mapping, false );
    frame_feats = sub_video_flat;
    motion_feats = sub_video_flat;
    frame_bin = itq_bin_mat;
    motion_bin = itq_bin_mat;
end
end
