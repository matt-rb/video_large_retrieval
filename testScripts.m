% fprintf(1,'here''s my integer:  ');
%      for i=1:9
%          fprintf(1,'\b%d',i); pause(.1)
%      end
%      fprintf('\n')




% k=1;
% while k<= length(candidate_frames_no)
%     imgs = cell(6,2);
%     for i=1:6
%         try
%         test = candidate_frames_no(k+i-1,:);
%         imgs{i,1} = imread(strcat('data/frames2/','frm_',num2str(test(1)),'.jpg'));
%         imgs{i,2} = strcat('Frame No',num2str(test(1)),' /Changes:',num2str(test(2)));
%         catch
%         end
%     end
%     
%     
%     close ;
%     fg = figure('KeyPressFcn',@(obj,evt) 0);
%     
%     for i=1:6
%         subplot(2,3,i);
%         h = imshow(imgs{i,1}, 'InitialMag',100, 'Border','tight');
%         title(imgs{i,2});
%         set(h, 'ButtonDownFcn',{@callback,i})
%     end
%     
%     %test = candidate_frames_no(k,:);
%     %imgs = imread(strcat('data/frames2/','frm_',num2str(test(1)),'.jpg'));
%     %imshow(imgs);
%     waitfor(gcf,'CurrentCharacter');
%     curChar=uint8(get(gcf,'CurrentCharacter'));
%     if curChar == 27
%         close all;
%         break; 
%     end
%     k = k+6;
% 
% end

%waitfor(gcf,'CurrentCharacter');
%curChar=uint8(get(gcf,'CurrentCharacter'));
%fprintf('Pressed .... %d \n',curChar);



%  av_files = dir('data/videoclips/*.avi'); 
%  for i=1:size(av_files)
%      movefile(strcat('data/videoclips/',av_files(i).name),strcat('data/videoclips/video',num2str(i+67),'.avi'));
%  end

for i=68:478
mkdir(strcat('data/frames',num2str(i)));
capture_frames(strcat('data/videoclips/video',num2str(i),'.avi'), strcat('data/frames',num2str(i)), 'frm');
%fprintf('ffmpeg -i video%d.avi -vcodec mjpeg -qscale 1 demo%d.avi\n',i,i);
end
    