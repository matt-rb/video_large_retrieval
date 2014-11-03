function [ candidate_frames_no ] = choose_candidate( bit_changes, min_change, is_bucket )
%CHOOSE_CANDIDATE Summary of this function goes here
%   Detailed explanation goes here

if (nargin<3) || isempty(is_bucket)
  eval_index = 1;
else
  eval_index = 2;
end
  
nFrames= length(bit_changes);
candidate_frames_no = [];
frm_no = 1;
while frm_no<nFrames
    
    if bit_changes(frm_no,eval_index)>min_change
        candidate_frames_no = [candidate_frames_no ; [frm_no,bit_changes(frm_no,eval_index)]];
    end
    frm_no = frm_no+1;
end

if size(candidate_frames_no,1)<10
    needed_frm = 10-size(candidate_frames_no,1);
    frm_dist = ceil((nFrames-5)/needed_frm);
    for i=1:needed_frm
        idx= frm_dist*i;
        candidate_frames_no = [candidate_frames_no ; [idx,bit_changes(idx,eval_index)]];
    end
end

