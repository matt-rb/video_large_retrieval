
clear all

test_parameter_cols.Category = 1;
test_parameter_cols.Percision = 100;
test_parameter_cols.Recall= 100;
test_parameter_cols.Count= 1;
test_parameter_cols.AVG= 1;

test_parameter_rows.Category = {'SitUp', 'GetOutCar', 'StandUp', 'AnswerPhone'...
                               , 'Kiss', 'HugPerson', 'SitDown', 'HandShake'};

test_parameter_rows.Percision = 0;
test_parameter_rows.Recall = 0;
test_parameter_rows.Count= 0;
test_parameter_rows.AVG= 0;
                           
[ testplan_table ] = build_testPlan_table( test_parameter_cols,test_parameter_rows );