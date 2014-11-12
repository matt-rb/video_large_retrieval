
%load('sub_videos.mat');
%load('annotation_my_more_cell.mat');

sub_train_set_index = [];
sub_test_set_index = [];
flat_dim = 20*size(sub_video_vectors,2);

for i=1:size(annotation_train,1)
    idx= mapped{strmatch(annotation_train(i,1), mapped(:,2), 'exact'),1};
    idx= find(sub_video_vectors_index(:,2)==idx);
    temp= sub_video_vectors_index(idx,:);
    sub_train_set_index = [ sub_train_set_index ; temp];
end

for i=1:size(annotation_test,1)
    idx= mapped{strmatch(annotation_test(i,1), mapped(:,2), 'exact'),1};
    idx= find(sub_video_vectors_index(:,2)==idx);
    temp= sub_video_vectors_index(idx,:);
    sub_test_set_index = [ sub_test_set_index ; temp];
end

sub_video_test_set_flat= zeros(size(sub_test_set_index,1),flat_dim);
sub_video_train_set_flat= zeros(size(sub_train_set_index,1),flat_dim);

for i=1:size(sub_test_set_index,1)
    start_idx=((sub_test_set_index(i,1)-1)*20)+1;
    end_idx=sub_test_set_index(i,1)*20;
    temp= sub_video_vectors(start_idx:end_idx,:);
    temp=reshape(temp,1,flat_dim);
    sub_video_test_set_flat(i,:)=temp;
end

for i=1:size(sub_train_set_index,1)
    start_idx=((sub_train_set_index(i,1)-1)*20)+1;
    end_idx=sub_train_set_index(i,1)*20;
    temp= sub_video_vectors(start_idx:end_idx,:);
    temp=reshape(temp,1,flat_dim);
    sub_video_train_set_flat(i,:)=temp;
end

save('sub_video_train_data','sub_test_set_index','sub_train_set_index','sub_video_test_set_flat','sub_video_train_set_flat', '-v7.3');