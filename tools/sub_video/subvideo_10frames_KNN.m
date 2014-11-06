
annotation_sub = zeros(size(sub_test_set_index,1),5);
fprintf ('%d tottal - annotaited :', size(sub_test_set_index,1));
for i=1:size(sub_test_set_index,1)
    print_counter(i);
    [IDX,D] = knnsearch(sub_video_train_set_flat,sub_video_test_set_flat(i,:),'K',5);
    annotation_sub(i,:)=IDX;
end
save('sub_video_annotation','annotation_sub');
fprintf ('\n');