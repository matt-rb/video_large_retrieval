function nFrames = capture_frames(videoFileAddrss, saveRoot, frameName, neededFrames)
% READ THE AVI
mov=VideoReader(videoFileAddrss);
% Extract information of MOV
get(mov);

if (nargin < 4) || isempty(neededFrames)
  nFrames = mov.NumberOfFrames;
else
  nFrames = neededFrames;
end
fprintf('%s Frames in the video : %s\n',num2str(nFrames),mov.Name);
%vidHeight = mov.Height;
%vidWidth = mov.Width;
% GRAB A SINGLE FRAME
k = 1;
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
    imwrite(F, strcat(saveRoot,'/', frameName,'_',num2str(i),'.jpg'));
    print_counter( i );
    k = k + 1;%(nFrames/10);
    i = i+1;
end
nFrames = i-1;
fprintf('\n')
fprintf('%s Frames Saved in %s/\n',num2str(nFrames),saveRoot);
end

%[im1,map] = frame2im(mov(1));
% SHOW THE FRAME
%imshow( im1 );
% SET THE COLORMAP PROPERLY SO THE IMAGE SHOWS CORRECTLY
%colormap( map );
% WRITE OUT THE FRAME TO A BMP FILE
%imwrite(im1,map,'clockFrame1.bmp');