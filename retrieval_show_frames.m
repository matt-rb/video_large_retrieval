function retrieval_show_frames( image_dir , frame_name, candidate_frames_no )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
k=1;
%while k<= length(candidate_frames_no)
while true
    imgs = cell(6,2);
    for i=1:6
        try
        test = candidate_frames_no(k+i-1,:);
        imgs{i,1} = imread(strcat(image_dir,'frames',num2str(test(1)),'/',frame_name,'_',num2str(test(2)),'.jpg'));
        imgs{i,2} = strcat('Video No',num2str(test(1)),' /Frame No:',num2str(test(2)));
        catch
        end
    end
    
    
    close ;
    figure('name',strcat('Total Key-Frames: ',num2str(length(candidate_frames_no))), 'units','normalized','outerposition',[0 0 1 1],'KeyPressFcn',@(obj,evt) 0);
    
    for i=1:6
        subplot(2,3,i);
        h = imshow(imgs{i,1}, 'InitialMag',100, 'Border','tight');
        title(imgs{i,2});
        set(h, 'ButtonDownFcn',{@callback,i})
    end
    
    %test = candidate_frames_no(k,:);
    %imgs = imread(strcat('data/frames2/','frm_',num2str(test(1)),'.jpg'));
    %imshow(imgs);
    waitfor(gcf,'CurrentCharacter');
    curChar=uint8(get(gcf,'CurrentCharacter'));
    
    if curChar == 27
        close all;
        break; 
    end
    if curChar == 29 
        if k<length(candidate_frames_no)
            k = k+6;
        end
        continue;
    end
    if curChar == 28
        if k>1
            k = k-6;
        end
        continue;
    end

end
function callback(o,e,idx)
   %# show selected image in a new figure
   figure(2), imshow(imgs{idx,1})
   title(imgs{idx,2})
end
end
