function [ per_video ] = retrival_by_video_index( frame_indexes,mapped, per_video  )
% Get retrived video frames and rearrange from frame_based to video_based
% list. each rows shown a video index and its common frames with the query
% video
%
%   input:
%       -frame_indexes: a vector contain query key_frames indexes and
%           correspond videos key_frames in dataset.
%           [ Key_frame_index , [ videos_Nos, frame_indexes] ]
%       -mapped: dataset mapped table and annotations.
%       -per_video: to append results to an exicting per_video vector.
%           [ dataset_video_No, [Common key_frames] , act1, act2, 0 ]
%
%   output:
%       -per_video : a list based on video index.
%           [ dataset_video_No, [Common key_frames] , act1, act2, 0 ]

    if not(exist('per_video','var'))
        per_video = [];
    end

    for i=1:size(frame_indexes,1)
        
        retrive_frames = cell2mat(frame_indexes(i,2));
        if (size(retrive_frames,1)>0)
            unique_retrive_frames = unique(retrive_frames(:,1));
        else
            unique_retrive_frames =[];
        end
        for frm_index=1:size(unique_retrive_frames,1)
            if not(exist('mapped','var'))
                act1 = '_';
                act2 = '_';
            else
                % find lables of video
                rows = cell2mat(mapped(:,1))==unique_retrive_frames(frm_index);
                actions = mapped(rows,3:4);
                act1 = actions{1};
                if size(actions{2},1)<1
                    act2 = '_';
                else
                    act2 = actions{2};
                end;
            end
            

            if size(per_video,1)>0
                video_ret_index = find(cell2mat(per_video(:,1))==unique_retrive_frames(frm_index));
                if ~ isempty(video_ret_index)
                    per_video(video_ret_index,2) = {[cell2mat(per_video(video_ret_index,2));...
                                              retrive_frames(find(retrive_frames(:,1)==unique_retrive_frames(frm_index),1),2)]};
                else
                    append = [ unique_retrive_frames(frm_index), {retrive_frames(find(retrive_frames(:,1)==unique_retrive_frames(frm_index),1),2)},act1,act2,0];
                    per_video =  [per_video; append ];
                end;   
            else
                append = [ unique_retrive_frames(frm_index), {retrive_frames(find(retrive_frames(:,1)==unique_retrive_frames(frm_index),1),2)},act1,act2,0];
                per_video =  [per_video; append ];
            end
        end

    %retrieval_show_frames( image_dir , frame_name, candidate_frames_no );
    end
    
end

