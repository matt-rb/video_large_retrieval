function [ buckets_change, bit_change ,check_val ] = claculat_bucket_changes( lsh_binary_vector1,lsh_binary_vector2, bucket_size )
%MEAN_DATA Summary of this function goes here
%   Detailed explanation goes here

bit_change = 0;
buckets_change = 0;
add_value = bucket_size -1;
bit_no=1;

while bit_no< length(lsh_binary_vector1)
    upper_band = bit_no+add_value;
    temp_sub = sum(xor(lsh_binary_vector1(bit_no:upper_band) , lsh_binary_vector2(bit_no:upper_band)));
    if temp_sub>0
        buckets_change = buckets_change +1;
    end
    bit_change = bit_change + temp_sub;
    bit_no = bit_no+bucket_size;
    
end
check_val = [bit_change, sum(xor(lsh_binary_vector1 , lsh_binary_vector2))];
end