function [ cell_data, ranked_list ] = sort_cells_by_col( cell_data, sort_col, make_unique, order )
%% get a cell data matrix and sort it based on given column number
%
%   input:
%       -cel_data : data matrix (cells)
%       -sort_col : column to based on sort
%       -make_unique : make uique value on the colums (default=false)
%       -order : sort order 'descend' or 'ascend' (default='descend')
%
%   output:
%       -cel_data : sorted data matrix
%       -ranked_list : normilized ranked list based on order
%
%% Example Usage:
%
%   [ cell_data, ranked_list ] = sort_cells_by_col( cell_data, 2, true, 'ascend' )
%   or:
%   [ cell_data, ranked_list ] = sort_cells_by_col( cell_data, 2 );

%% Set default parameters
if not(exist('order','var'))
    order='descend';
end

if not(exist('make_unique','var'))
    make_unique=false;
end

%% Remove frames redundancies per video
if make_unique
    for i=1:size(cell_data,1)
        input_vector = cell2mat(cell_data(i,sort_col));
        [~, idxs, ~] = unique(input_vector);
        cell_data(i,2) = {input_vector(sort(idxs))};
    end
end

%% Sort and Ranking
[~, Index] = sort(cellfun('size', cell_data(:,sort_col), 1), order);
cell_data = cell_data(Index(:,1),:);

res_count= size(cell_data,1);
ranked_list = (1:res_count)'/res_count;
ranked_list = sort(ranked_list,'descend');
end

