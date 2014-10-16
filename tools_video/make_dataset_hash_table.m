function [ dataset_hash_table ] = make_dataset_hash_table( dataset_frame_table )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%sorted_frames = sortrows(dataset_frame_table,3);
binary_size = size(dataset_frame_table(1,4:end),2);
index_values = grpstats((dataset_frame_table(:,3)),dataset_frame_table(:,3));
dataset_hash_table = [];
fprintf(1,'Buildup Hash Table...\nCategories : %d Indexing Category No :  ',size(index_values,1));
for i=1:size(index_values,1) 
    print_counter( i );
    temp_row = [index_values(i), {find(dataset_frame_table(:,3)==index_values(i))}, de2bi(index_values(i),binary_size)];
    dataset_hash_table = [dataset_hash_table;temp_row];
end
fprintf('\n');
end

