function [ pixel_vector ] = pixel_feature( frames_root, nFrames, new_size )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
frm_no=1;
vector_size=prod(new_size);
pixel_vector = zeros(nFrames, vector_size);
fprintf(1,'Total Frames : %d Computed Frame No:  ',nFrames);
while frm_no<nFrames+1
    img = imread(strcat(frames_root,num2str(frm_no),'.jpg'));
    img = imresize(img, new_size(1:2));
    pixel_vector(frm_no,:) = reshape(img,1,vector_size);
    print_counter( frm_no );
    frm_no = frm_no+1;
end
fprintf('\n');
end

