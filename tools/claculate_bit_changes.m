function [ bit_changes ] = claculate_bit_changes( H )
%MEAN_DATA Summary of this function goes here
%   Detailed explanation goes here
nFrames = size(H,1);
bit_changes = zeros(nFrames, 2);
frm_no=1;

while frm_no< nFrames

    temp_sub = xor (max(H(frm_no,:), 0)  , max(H(frm_no+1,:), 0));
    bit_changes(frm_no,1) = sum(temp_sub);
    bit_changes(frm_no,2) = 0;
    frm_no = frm_no+1;
    
end

end

