function [ precision, recall, max_cat ] = precision_recall( ranked_list, top_no, query_category,query_category2, train_gategory_table )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    dataset_act_col = train_gategory_table.Properties.VariableNames{1};
    dataset_count_col = train_gategory_table.Properties.VariableNames{2};
    all_cat_no = train_gategory_table.(dataset_count_col)(strmatch(query_category,train_gategory_table.(dataset_act_col),'exact'));
    if size(char(query_category2),2)>0
        all_cat_no = all_cat_no + train_gategory_table.(dataset_count_col)(strmatch(query_category2,train_gategory_table.(dataset_act_col),'exact'));
    end
    temp= ranked_list(1:top_no,:);
    cats= temp(:,3);
    cats2= temp(:,4);
    grp_cats = grpstats(cell2table(cats),'cats');
    grp_cats2 = grpstats(cell2table(cats2),'cats2');
    
    for i=1:size(grp_cats2,1)
        idx_cat = strmatch(grp_cats2.cats2(i),grp_cats.cats,'exact');
        if idx_cat >0
            grp_cats.GroupCount(idx_cat) = grp_cats.GroupCount(idx_cat) + grp_cats2.GroupCount(i);
        else
            TT= cell2table([grp_cats2.cats2(i),grp_cats2.GroupCount(i)]);
            TT.Properties.VariableNames{1} = grp_cats.Properties.VariableNames{1};
            TT.Properties.VariableNames{2} = grp_cats.Properties.VariableNames{2};
            grp_cats = [grp_cats;TT];
        end
            
    end
    
    same_cat_no = grp_cats.GroupCount(strmatch(query_category,grp_cats.cats,'exact'));
    if size(char(query_category2),2)>0
        same_cat_no = same_cat_no + grp_cats.GroupCount(strmatch(query_category2,grp_cats.cats,'exact'));
    end
    
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
    max_cat = grp_cats{grp_cats.GroupCount==max(table2array(grp_cats(:,2))),1};
    
end

