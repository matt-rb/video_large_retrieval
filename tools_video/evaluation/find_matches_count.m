%% Find Matched Values between two vectors

function [ matches_counts_vector ] = find_matches_count( query_vector, reference_vector )
%% Parameters:
%
%   input:
%       -query_vector: values that needs to find their matches.
%       -reference_vector: refrence values to find matches from a query
%       vector. 
%
%   -output:
%       -matches_counts: same as query_vector plus a column that represent
%       the number of found matches of the value in the reference_vector.
%   
%% Example
%   reference_vector = {'ee'; 'rr'; 'sst' ; 'rr' };
%   query_vector = {'rr'};
%   [ matches_counts_vector ] = find_matches_count( query_vector, reference_vector );
%
%% Initialization
guery_items_no = size(query_vector,1);
if iscell(reference_vector)
    matches_counts_vector = [ query_vector, cell(guery_items_no,1)];
    % datatype validation of query vector
    if ~iscell(query_vector)
       error('find_matches_count:argChk', 'Query and Reference vectors should have the same type');
    end     
else
    matches_counts_vector = [ query_vector, zeros(guery_items_no,1)];
    % datatype validation of query vector
    if iscell(query_vector)
       error('find_matches_count:argChk', 'Query and Reference vectors should have the same type');
    end   
end

%% Find Values
if iscell(reference_vector)
    for guery_item=1:guery_items_no
        match_count = sum(cellfun(@(x) strcmp(x,query_vector{guery_item}),reference_vector));
        matches_counts_vector(guery_item,end)={match_count};
    end
else
    for guery_item=1:guery_items_no
        match_count = size(find(reference_vector==query_vector(guery_item)),1);
        matches_counts_vector(guery_item,end)=match_count;
    end
end

