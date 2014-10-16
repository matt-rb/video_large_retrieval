aviobj = VideoWriter('Demo.avi');
aviobj.FrameRate = 25;
open(aviobj);

for video_no=1:1

videoFileAddrss = strcat('video',num2str(video_no),'.avi');
mov=VideoReader(videoFileAddrss);
% Extract information of MOV
get(mov);

nFrames = mov.NumberOfFrames;

fprintf('%s Frames in the video : %s\n',num2str(nFrames),mov.Name);
%vidHeight = mov.Height;
%vidWidth = mov.Width;
% GRAB A SINGLE FRAME
k = 50;
i = 1;
fprintf(1,'saved frame :  ');
while k < nFrames
    % Capture frame No K 
    try
    F = read(mov, k);
    catch
    k = k+1;
    continue;
    end
    % map to gray
    %grayF = rgb2gray(F);
    % resize to 504x896
    %grayF = imresize(grayF,0.70);
    F = imresize (F, [310 588]);
    writeVideo(aviobj,F);
    %imwrite(F, strcat(saveRoot,'/', frameName,'_',num2str(i),'.jpg'));
    print_counter( i );
    k = k + 1;%(nFrames/10);
    i = i+1;
end
nFrames = i-1;
fprintf('\n')
fprintf('Frames Saved for video no %s/\n',num2str(nFrames));
end
close(aviobj);