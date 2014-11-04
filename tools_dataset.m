%------------------ Clean Mapping-------------------------------------

% for i=1:size(mapped,1)
%     if size(strfind(mapped.videoName{i}, 'Pianist' ),1)>0
%         %mapped.videoName{i} = strcat(mapped.videoName{i},'.avi');
%         mapped.videoName{i} = strrep(mapped.videoName{i}, 'Pianist', 'Pianist,');
%     end
% end

for i=1:size(trainclean,1)
    if strmatch(trainclean.videoName{i}, mapped(:,2), 'exact')>0
        inx= strmatch(trainclean.videoName{i}, mapped(:,2), 'exact');
        mapped{inx,3}=trainclean.Act1{i};
        mapped{inx,4}=trainclean.Act2{i};
        mapped{inx,5}=trainclean.frames{i};
    end
end


%------------------------- Buildup Mapping Table -------------------------

% for i=1:size(mapped,1)
%     if size(strmatch(mapped.videoName{i}, annotation_test.videoName),1)<1
%         if size(strmatch(mapped.videoName{i}, annotation_train.videoName),1)<1
%             last_index = size(annotation_train,1)+1;
%             annotation_train.videoName{last_index}= mapped.videoName{i};
%             annotation_train.Act1{last_index}= mapped.Act1{i};
%             annotation_train.Act2{last_index}= mapped.Act2{i};
%             
%         end
%     end
%         
% end


% counter = 1;
% for i=1:size(annotation_test,1)
%     if size(strmatch(annotation_test.videoName{i}, annotation_train.videoName),1)>0
%        fprintf('%d - %s\n',counter, annotation_test.videoName{i});
%        counter = counter+1;
%     end
%         
% end


%------------- collect data and Make dataset train ready ------------------
% train_video_index = zeros(size(annotation_train,1), 1);
% itq_data_root = 'features_caffe/';
% 
% for i=1:size(annotation_train,1)
%     train_video_index(i)=mapped.videoNo(strmatch(annotation_train.videoName{i}, mapped.videoName));
% end
% 
% [ temp_features ] = join_fetures( itq_data_root, train_video_index );
