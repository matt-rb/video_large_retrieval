function [ hash_table ] = make_standard_hash_table( hash_table, size_hash )
% if size of hashtable be less than index
%   input:
%       -hash_table : generated hash table
%       -size_hash : standard size (number of rows in hash table)

tmp_hash_table= cell(size_hash);

for idx=1:size_hash(1)
    
    hash_data=hash_table(cellfun(@(x) x==(idx-1),hash_table(:,1)),2:3);
    if size(hash_data,1)>0
       tmp_row = [idx-1,hash_data];
    else
       tmp_row = {idx-1,[],[]};
    end
    
    tmp_hash_table(idx,:) = tmp_row;
end

hash_table = tmp_hash_table;

end

