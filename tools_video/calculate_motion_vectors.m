function [ motion_vectors ] = calculate_motion_vectors( feats, candidate_frames_no )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
motion_vectors =zeros(size(candidate_frames_no,1),size(feats,2));

for i=1:size(candidate_frames_no,1)
    if i==1
       start_idx=1;
    else
       start_idx=candidate_frames_no(i-1,1);
    end
    end_idx = candidate_frames_no(i,1);
    [ motion_vector ] = motion_features( feats(start_idx:end_idx,: ));
    motion_vectors(i,:) =  motion_vector;   
end

end

