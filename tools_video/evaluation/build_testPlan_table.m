function [ testplan_table ] = build_testPlan_table( test_cols, test_rows )
%% Description
% build a test plan table for evaluation. parameters should send in the 
% form of struct. Columns struct and Rows struct. First col and row will
% be considered as header title and side title values.
%
%   input:
%       -test_cols : table columns struct. struct has two values:
%           1 - Name of Column
%           2 - Number of repeat
%       -test_rows : table rows struct. struct has two values:
%           1 - Name of Row (HAVE TO BE same as Columns)
%           2 - Default Value
%
%   output:
%       -testplan_table : test plan table in the type of 'dataset'
%
%--------------------------------------------------------------------------
%%                           EXAMPLE USAGE
%
% ------ Define Columns and Number of Repeat 
%
% test_parameter_cols.Category = 1;
% test_parameter_cols.Percision = 40;
% test_parameter_cols.Recall= 40;
% test_parameter_cols.Count= 1;
% test_parameter_cols.AVG= 1;
% 
% ------ Define Rows and Default Values 
%
% test_parameter_rows.Category = {'SitUp', 'GetOutCar', 'StandUp', 'AnswerPhone'...
%                                , 'Kiss', 'HugPerson', 'SitDown', 'HandShake'};
% test_parameter_rows.Percision = 0;
% test_parameter_rows.Recall = 0;
% test_parameter_rows.Count= 0;
% test_parameter_rows.AVG= 0;
%                            
% [ testplan_table ] = build_testPlan_table( test_parameter_cols,test_parameter_rows );
%%--------------------------------------------------------------------------
%%
if not(size(fieldnames(test_cols),1)==size(fieldnames(test_rows),1))
    error('build_testPlan_table:argChk', 'Columns and Rows should have same field');
end

% initial header and budy
sum_col_no = sum(struct2array(test_cols));
sum_row_no= size(test_rows.Category,2);
header = cell(1,sum_col_no);
sample_row = cell(1,sum_col_no);

% fill header and one sinle row
fields_name = fieldnames(test_cols);
header_counter=1;
for fields_idx=1:size(fields_name,1)
    col_no = test_cols.(fields_name{fields_idx});
    if col_no>1
        for i=1:col_no   
            header(header_counter) = strcat(fields_name(fields_idx),num2str(i));
            sample_row(header_counter) = {test_rows.(fields_name{fields_idx})};
            header_counter = header_counter+1;
        end
    else
        header(header_counter) = strcat(fields_name(fields_idx));
        sample_row(header_counter) = {test_rows.(fields_name{fields_idx})};
        header_counter = header_counter+1;
    end
end

% repeat sample row for all table as initalization and assign side title
body= repmat(sample_row,[sum_row_no 1]);
body(:,1)= test_rows.(fields_name{1});

% join header and body to make the final table
cell_cat = [header;body];
testplan_table = cell2dataset(cell_cat);
    

end

