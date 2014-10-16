function show_video( video_no, start_frame, end_frame )

frames_root = strcat('data/frames/frames',num2str(video_no),'/frm_');
listing = dir(strcat('data/frames/frames',num2str(video_no),'/','*.jpg'));
listing = extractfield(listing,'name');
nFrames = size(listing,2);
fprintf('Total video Frames: %s Current video : \n', num2str(nFrames));

if (nargin < 2) || isempty(start_frame)
  start_frame = 1;
end

if (nargin < 3) || isempty(end_frame)
  end_frame = nFrames;
end

for frm_no=start_frame:end_frame
    print_counter( frm_no );
    img=imread(strcat(frames_root,num2str(frm_no),'.jpg'));
    %figure(1);
    %subplot(2,1,1),imshow(img);
   figure(1),imshow(img);
   curChar=uint8(get(gcf,'CurrentCharacter'));
    
    if curChar == 27
        close all;
        break; 
    end
 
end
fprintf('\n');
close all;
end

