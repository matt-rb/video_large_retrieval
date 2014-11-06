function [ frm_list ] = search_by_keyframes( query_data, database_keyframes, image_dir, guery_dir, visualize )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
frm_list = [];
for i=1:size(query_data,1)
    
    new_data =  find (bi2de(database_keyframes(:,2:end))==bi2de(query_data(i,2:end),'left-msb'));
    
    if size(new_data)>0
        new_data = database_keyframes(new_data,:);
        if visualize
            imshow(strcat(guery_dir, '/frm_', num2str(query_data(i)),'.jpg'));
            waitfor(gcf,'CurrentCharacter');
            curChar=uint8(get(gcf,'CurrentCharacter'));
            if curChar == 27
                close all;
                return; 
            end
            close all;
            show_keyframes( image_dir , 'frm', new_data );
        end
        frm_list = [frm_list; new_data];
    end

end

end

