function [ motion_vectors ] = calculate_motion_vectors( feats, candidate_frames_no )
% Calculate all the motion features between key_farmes in the given video.
%
%   input:
%       -feats : video frames feature vectors
%       -candidate_frames_no : key_frames index
%
%   output:
%       -motion_vectors: computed motion_flow_vector between video keyframes.
%           [ videoNo, relatedKey_frame, decimalValue, binaries ]


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

function [ motion_vector ] = motion_features( feats )
% Calculate sum diffrences of features vectors between two keyframes
%   Input :
%       feats : feature vectors between two keyframes
%   Output:
%       motion_vector : sum of diffrences represented as motion_flow_vector

motion_vector = feats(1:end-1,:) - feats(2:end,:);
motion_vector = sum(motion_vector,1)/size(motion_vector,1);

end

