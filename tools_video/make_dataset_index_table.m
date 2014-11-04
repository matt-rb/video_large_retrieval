function [ dataset_hash_table ] = make_dataset_index_table( dataset_frame_table )
% Build up hash table index for key_frames table regarding to the
% assosiated binary codes.
%
%   input:
%       -dataset_frame_table : table of stored key_frames.
%   output:
%       -dataset_hash_table : hash table index for key_frames
%       [ hash_code , key_frames_idx_in_frames_table , binaries ]

% Get binares indexes (unique decimal values)
binary_size = size(dataset_frame_table(1,4:end),2);
index_values = grpstats((dataset_frame_table(:,3)),dataset_frame_table(:,3));

dataset_hash_table = cell(size(index_values,1),3);
fprintf(1,'Buildup Hash Table...\nCategories : %d Indexing Category No :  ',size(index_values,1));
for i=1:size(index_values,1) 
    print_counter( i );
    temp_row = [index_values(i), {find(dataset_frame_table(:,3)==index_values(i))}, de2bi(index_values(i),binary_size)];
    dataset_hash_table(i,:) = temp_row;
end
fprintf('\n');
end

