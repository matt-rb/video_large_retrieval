

%------------------ initialization --------------------------------------

clear all;
frame_name = 'frm';
min_change = 0;
video_no = 478;
image_dir = 'data/frames/';
itq_data_root = 'features_caffe/';
train_data_file_name = strcat(itq_data_root,'train_out/itq_train_data_10bit_478caffe_H.mat');
annotation_file_name = strcat('annotation_my.mat');
load(train_data_file_name);
load(annotation_file_name);
load('features_caffe/dataset_frame_table2.mat');
load('features_caffe/dataset_hash_table2.mat');





%------------------ TEST PLAN --------------------------------------------
 cell_cat = {'Category','Percision1','Percision2','Percision3','Percision4','Percision5','Percision6','Percision7','Percision8'...
                            ,'Recall1','Recall2','Recall3','Recall4','Recall5','Recall6','Recall7','Recall8','Count', 'AVG';
                    'SitUp',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'GetOutCar',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'StandUp',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'AnswerPhone',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'Kiss',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'HugPerson',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'SitDown',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'';
                    'HandShake',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,''};

    sum_table = cell2table(cell_cat(2:end,:));
    sum_table.Properties.VariableNames = cell_cat(1,:);
    
for test_index=1:size(annotation_test,1)
    %if strmatch(annotation_test.videoName{test_index}, mapped.videoName, 'exact')>0
    inx= strmatch(annotation_test.videoName{test_index}, mapped.videoName, 'exact');
    query_no = mapped.videoNo(inx);
    query_features_file = strcat(itq_data_root,'videos/video',num2str(query_no),'_data.mat');
    query_dir = strcat(image_dir,'frames',num2str(query_no));
    load(query_features_file);
    video_query_features = feats;
    fprintf ('%d of %d - Video No : %d \t Category1: %s  \t Category2: %s \n', test_index,size(annotation_test,1), query_no, char(mapped.Act1(inx)),char(mapped.Act2(inx)));
    [ frame_indexes, query_keyframes_org ] = retrieve_video( video_query_features, pca_mapping, itq_rot_mat, dataset_hash_table, min_change ); 
    [ per_video ] = sort_retrival_by_video_index( frame_indexes,dataset_frame_table,query_no,mapped  );
    history_frames=query_keyframes_org;
    while size(per_video,1)<395
        %if size(query_keyframes_org,1)>100
            tt= randi([1 size(query_keyframes_org,1)],ceil(size(query_keyframes_org,1)/3));
            query_keyframes = query_keyframes_org(tt,:);
        %else
        %    query_keyframes = query_keyframes_org;
        %end
        frm_idx =1;
        while frm_idx<=size(query_keyframes,1)
            bin_val = de2bi(query_keyframes(frm_idx,2),size(pca_mapping,2));
            while size(find(history_frames(:,2)==bi2de(bin_val)),1)>0
                candidate_bit = randi([1 size(pca_mapping,2)]);
                bin_val(candidate_bit) = not(bin_val(candidate_bit));
            end        
            query_keyframes(frm_idx,2) = bi2de(bin_val);
            history_frames = [history_frames; query_keyframes(frm_idx,:)];
            frm_idx=frm_idx+1;
        end
        [ frame_indexes, query_keyframes ] = retrieve_video( video_query_features, pca_mapping, itq_rot_mat, dataset_hash_table, min_change,query_keyframes ); 
        [ per_video ] = sort_retrival_by_video_index( frame_indexes,dataset_frame_table,query_no,mapped, per_video  );
    end
    
    for i=1:size(per_video,1)
        input_vector = cell2mat(per_video(i,2));
        [~, idxs, ~] = unique(input_vector);
        per_video(i,2) = {input_vector(sort(idxs))};
    end
    [dummy, Index] = sort(cellfun('size', per_video, 1), 'descend');
    per_video = per_video(Index(:,2),:);
    
    
    %--------- Buid Summary Table of Categories " Act1 | GroupCount "
    grp_cats = grpstats(annotation_train(:,3),'Act1');
    grp_cats2 = grpstats(annotation_train(:,4),'Act2');
    for i=1:size(grp_cats2,1)
        idx_cat = strmatch(grp_cats2.Act2(i),grp_cats.Act1,'exact');
        if idx_cat >0
            grp_cats.GroupCount(idx_cat) = grp_cats.GroupCount(idx_cat) + grp_cats2.GroupCount(i);
        else
            grp_cats.Act1(size(grp_cats,1)+1) = grp_cats2.Act2(i);
            grp_cats.GroupCount(size(grp_cats,1)+1) = grp_cats2.GroupCount(i); 
        end       
    end
    
   
    
    
    idx_cat = strmatch(mapped.Act1(inx),sum_table.Category,'exact');
    sum_table.Count(idx_cat) = sum_table.Count(idx_cat) + 1;
    if length(char(mapped.Act2(inx)))>1
        idx_cat2 = strmatch(mapped.Act2(inx),sum_table.Category,'exact');
        sum_table.Count(idx_cat2) = sum_table.Count(idx_cat2) + 1;
    end
    for pers=1:8
        if pers*10 > size(per_video,1)
            continue;
        end
        if length(char(mapped.Act1(inx)))>1
            [ precision, recall, max_cat ] = precision_recall( per_video, pers*10, mapped.Act1(inx), mapped.Act2(inx) , grp_cats );
            fprintf ('%d - Percision : %f  - recall: %f \n', pers*10, precision, recall);
            sum_table.(strcat('Percision',num2str(pers)))(idx_cat) = sum_table.(strcat('Percision',num2str(pers)))(idx_cat) + precision;
            sum_table.(strcat('Recall',num2str(pers)))(idx_cat) = sum_table.(strcat('Recall',num2str(pers)))(idx_cat) + recall;
            %sum_table.AVG(idx_cat) = max_cat(1);
        end
        if length(char(mapped.Act2(inx)))>1
            %[ precision, recall , max_cat] = precision_recall( per_video, pers*10, mapped.Act2(inx), grp_cats );
            %fprintf ('%d - Percision : %f  - recall: %f \n', pers*10, precision, recall);
            sum_table.(strcat('Percision',num2str(pers)))(idx_cat2) = sum_table.(strcat('Percision',num2str(pers)))(idx_cat2) + precision;
            sum_table.(strcat('Recall',num2str(pers)))(idx_cat2) = sum_table.(strcat('Recall',num2str(pers)))(idx_cat2) + recall; 
            %sum_table.AVG(idx_cat) = max_cat(1);
        end
    end
    
end
for i=1:8
    for pers=1:8
        sum_table.(strcat('Percision',num2str(pers)))(i) = sum_table.(strcat('Percision',num2str(pers)))(i)/sum_table.Count(i);
        sum_table.(strcat('Recall',num2str(pers)))(i) = sum_table.(strcat('Recall',num2str(pers)))(i)/sum_table.Count(i);
    end
end