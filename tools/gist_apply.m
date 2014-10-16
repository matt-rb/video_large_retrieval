function [ gists, param ] = gist_apply( images_root, nFrames )
%GIST_APPLY Summary of this function goes here
%   Detailed explanation goes here

% Parameters:
clear param
%param.imageSize = [256 256]; % it works also with non-square images
param.orientationsPerScale = [8 8 8 8];
param.numberBlocks = 4;
param.fc_prefilt = 4;
gists = zeros(nFrames, 512);
k=1;
fprintf(1,'Total Frames : %d Computed Frame No:  ',nFrames);
while k <= nFrames
    img = imread(strcat(images_root,num2str(k),'.jpg'));
    [gist, param] = LMgist(img, '', param);
    gists(k,:) = gist;
    print_counter( k );
    k = k+1;
%     figure
%     subplot(121)
%     imshow(img)
%     title('Input image')
%     subplot(122)
%     showGist(gist, param)
%     title('Descriptor')
    
end
fprintf('\n');
end

