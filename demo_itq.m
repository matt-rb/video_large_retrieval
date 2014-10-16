%clear all;
video_no= '101';
%load(strcat('features_gist/video',video_no,'_data.mat'));
%load(strcat('features_caffe/video',video_no,'_data.mat'));
%nFrames = 265;
lsh_size = 15;
vector_size=512;
%vector_size=4096;
n_iter = 50;

%min_change = 6;
frame_name = 'frm';
image_dir = strcat('data/frames',video_no);

%nFrames = capture_frames(strcat('data/video',video_no,'.avi'),image_dir,frame_name,nFrames);
%nFrames = capture_frames(strcat('data/video',video_no,'.mp4'),image_dir,frame_name);

%[gists, param]  = gist_apply( strcat('data/frames',video_no,'/frm_'), nFrames );

%gists2= feats;
gists2= gists;
temp = gists2 - ones(size(gists2))*diag(mean(gists2));
norm_temp = temp/norm(temp);
[mappeddata, mapping] = my_pca(norm_temp, lsh_size);

[bin_mat,rot_mat] = ITQ(mappeddata, n_iter);
H = bin_mat;

bit_changes = claculate_bit_changes( H, nFrames );

%projected_pca = (mapping.M'*norm_temp')';

%min_change= mean(bit_changes(bit_changes>4));
min_change = 1;
candidate_frames_no = choose_candidate(bit_changes, min_change);

show_keyframes( image_dir , frame_name, candidate_frames_no );



