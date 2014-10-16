function [ per_video ] = sort_retrival_by_video_index( frame_indexes,dataset_frame_table,query_no,mapped, per_video  )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    if not(exist('per_video','var'))
        per_video = [];
    end

    for i=1:size(frame_indexes,1)
        selected = cell2mat(frame_indexes(i,2));
        retrive_frames = dataset_frame_table(selected,1:2);
        candidate_frames_no = [[str2double(query_no) cell2mat(frame_indexes(i,1))] ; retrive_frames];
        unique_retrive_frames = unique(retrive_frames(:,1));
        for frm_index=1:size(unique_retrive_frames,1)
            rows = mapped.videoNo==unique_retrive_frames(frm_index);
            actions = mapped(rows,{'Act1','Act2'});
            if size(actions,1)>0
                act1 = actions.Act1;
                act2= actions.Act2;
            else 
               act1 = '_';
               act2= '_';
            end
            if size(per_video,1)>0
                video_ret_index = find(cell2mat(per_video(:,1))==unique_retrive_frames(frm_index));
                if ~ isempty(video_ret_index)
                    per_video(video_ret_index,2) = {[cell2mat(per_video(video_ret_index,2));...
                                              retrive_frames(find(retrive_frames(:,1)==unique_retrive_frames(frm_index),1),2)]};
                else
                    append = [ unique_retrive_frames(frm_index), {retrive_frames(find(retrive_frames(:,1)==unique_retrive_frames(frm_index),1),2)},act1,act2];
                    per_video =  [per_video; append ];
                end;   
            else
                append = [ unique_retrive_frames(frm_index), {retrive_frames(find(retrive_frames(:,1)==unique_retrive_frames(frm_index),1),2)},act1,act2];
                per_video =  [per_video; append ];
            end
        end

    %retrieval_show_frames( image_dir , frame_name, candidate_frames_no );
    end
    
end

