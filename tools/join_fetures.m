function [ temp_features ] = join_fetures( features_data_root, train_video_index )

all_frames_count=0;
fprintf('Load Video Frames...\n');
for i=1:size(train_video_index,1)
    data_no = train_video_index(i);
    load(strcat(features_data_root,'video',num2str(data_no),'_data.mat'));
    all_frames_count = all_frames_count + size(feats,1);
end
fprintf('Total Videos Frames : %d ',all_frames_count);

temp_features = zeros(all_frames_count, 4096);
fprintf(1,'Total Videos : %d Attached video features No :  ',size(train_video_index,1));
current_frame = 0;
for i=1:size(train_video_index,1)
    data_no = train_video_index(i);
    print_counter( i );
    load(strcat(features_data_root,'video',num2str(data_no),'_data.mat'));
    %temp_features = [temp_features;gists];
    temp_features(current_frame+1:current_frame+size(feats,1),:) = feats;
    current_frame = current_frame+size(feats,1);
end;
fprintf('\n');
end

