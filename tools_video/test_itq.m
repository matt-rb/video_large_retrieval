function [ itq_bin_mat ] = test_itq( data_features, itq_rot_mat, pca_mapping )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%load(input_data_file);
%temp = gists - ones(size(gists))*diag(mean(gists));
data_features=bsxfun(@minus,data_features,mean(data_features));
norm_temp=bsxfun(@rdivide,data_features,sqrt(sum(data_features.^2,2)));
% temp = data_features - ones(size(data_features))*diag(mean(data_features));
% norm_temp = temp/norm(temp);
projected_pca = norm_temp * pca_mapping;
itq_bin_mat = sign(max(projected_pca * itq_rot_mat,0));

end

