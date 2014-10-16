clear all;
video_index=62;
while video_index<68

startup;
video_no= num2str(video_index);
frame_name = 'frm';
image_dir = strcat('data/frames',video_no);
mkdir(image_dir);
nFrames = capture_frames(strcat('data/video',video_no,'.avi'),image_dir,frame_name);
[gists, param]  = gist_apply( strcat('data/frames',video_no,'/frm_'), nFrames );
save(strcat('video',video_no,'_data'));
video_index=video_index+1;
clear gist and image_dir and nFrames and param;
end