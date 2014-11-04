function [ precision, recall ] = precision_recall( ranked_list, top_no, query_category,query_category2, train_gategory_table )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    dataset_act_col = train_gategory_table.Properties.VarNames{1};
    dataset_count_col = train_gategory_table.Properties.VarNames{2};
    all_cat_no = train_gategory_table.(dataset_count_col)(strmatch(query_category,train_gategory_table.(dataset_act_col),'exact'));
    if size(char(query_category2),2)>0
        all_cat_no = all_cat_no + train_gategory_table.(dataset_count_col)(strmatch(query_category2,train_gategory_table.(dataset_act_col),'exact'));
    end
    temp= ranked_list(1:top_no,:);
    cats= temp(:,3);
    cats2= temp(:,4);
    grp_cats = grpstats(cell2dataset(['cats';cats]),'cats');
    grp_cats2 = grpstats(cell2dataset(['cats2';cats2]),'cats2');
    
    
    same_cat_no = sum(grp_cats.GroupCount(strmatch(query_category,grp_cats.cats,'exact'))) + ...
                  sum(grp_cats2.GroupCount(strmatch(query_category,grp_cats2.cats2,'exact'))) + ...
                  sum(grp_cats.GroupCount(strmatch(query_category2,grp_cats.cats,'exact'))) + ...
                  sum(grp_cats2.GroupCount(strmatch(query_category2,grp_cats2.cats2,'exact')));
    
    precision = (same_cat_no/top_no)*100;
    recall = (same_cat_no/all_cat_no)*100;
    if size(precision,1)>0
    else
        precision=0;
    end
    if size(recall,1)>0
    else
        recall=0;
    end
    
end

