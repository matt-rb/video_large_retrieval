function [ motion_vector ] = motion_features( feats )
% Calculate sum diffrences of features vectors between two keyframes
%   Input :
%       feats : feature vectors between two keyframes
%   Output:
%       motion_vector : sum diffrences represented as motion_flow_vector

motion_vector = feats(1:end-1,:) - feats(2:end,:);
motion_vector = sum(motion_vector,1);

end

