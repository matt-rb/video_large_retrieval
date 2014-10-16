function [bit_changes, check_vals ] = claculate_bit_changes_per_bucket( H, nFrames, bucket_size )
%MEAN_DATA Summary of this function goes here
%   Detailed explanation goes here

bit_changes = zeros(nFrames, 2);
check_vals = zeros(nFrames, 2);
frm_no=1;

while frm_no< nFrames
    [buckets_change, bit_change, check_val] = claculat_bucket_changes( max(H(frm_no,:), 0),max(H(frm_no+1,:), 0), bucket_size );
    bit_changes(frm_no,1) = bit_change;
    bit_changes(frm_no,2) = buckets_change;
    check_vals(frm_no,:) =check_val;
    frm_no = frm_no+1; 
end

end

