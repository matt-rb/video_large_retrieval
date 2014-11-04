function  candidate_frames_no  = choose_keyframes( binary_vectors, min_change, is_bucket )
% Select key_frames based on required minimum number of bit changes
%
%   input:
%       -bit_changes : bit changes vector.
%       -min_change : minimum change in binaries to consider as key_frame.
%
%   output:
%       -candidate_frames_no : index of key_frames.
%           [ Key_frame_index , numberOfBitChanges ]
      

min_needed_frm = 10;

if (nargin<3) || isempty(is_bucket)
  eval_index = 1;
else
  eval_index = 2;
end

[bit_changes] = claculate_bit_changes( binary_vectors );


frms_idx = find(bit_changes(:,eval_index)>min_change); 
candidate_frames_no = [frms_idx, bit_changes(frms_idx,eval_index)];

if size(candidate_frames_no,1)<min_needed_frm
    nFrames = size(binary_vectors,1);
    frm_dist = fix((nFrames-5)/min_needed_frm);
    frm_idx = (1:min_needed_frm)'*frm_dist;
    candidate_frames_no = [ frm_idx , bit_changes(frm_idx,eval_index)];
end

end

function [ bit_changes ] = claculate_bit_changes( binary_vectors )
% Calculate the number of bits changes between two cosecutive frames in the
% given video.
%
%   input:
%      -binary_vectors : binary vectors of video frames features
%
%   output:
%       -bit_changes : Vector of bits changes between two cosecutive
%           frames.
%           [ frameNo , numberOfBitChanges ]


temp_sub= xor (max(binary_vectors(1:end-1,:), 0)  , max(binary_vectors(2:end,:), 0));
bit_changes = sum(temp_sub,2);

end

