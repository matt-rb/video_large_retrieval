function [ hash_table ] = make_hash_from_index( hash_index , content_table )
% Get hash index table and correspond data table and combine index with
% related contents.
%   input:
%       -hash_index : matrix of cells. idx_code is decimal of binary code
%       [ [idx_code] , [index of idx_codes in content_table] , [binaries] ]
%       -content_table : table of "key_frames" or "motion_vectors".
%       [ [video_no] , [frame_index] , [decimal_value] , [binaries] ]


fprintf(1,'Combine Hash index and content tables...\nItems : %d Combined Items No. :  ',size(hash_index,1));
hash_table = cell(size(hash_index,1),3);
for i=1:size(hash_index,1) 
    print_counter( i );
    mat_idx=cell2mat(hash_index(i,2));
    temp_row = [hash_index(i,1), {content_table(mat_idx,1:2)}, hash_index(i,3)];
    hash_table(i,:) = temp_row;
end
fprintf('\n');
end


