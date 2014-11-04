function [ itq_bin_mat ] = test_itq( data_features, itq_rot_mat, pca_mapping )
% Mapp feature vectors to itq binreies
%
%   input:
%       -data_features : feature vectors
%       -itq_rot_mat : ITQ rotation matrix
%       -pca_mapping : PCA eigen vectors
%
%   output:
%       -itq_bin_mat: feature vectors mapped binaries.

data_features=bsxfun(@minus,data_features,mean(data_features));
norm_temp=bsxfun(@rdivide,data_features,sqrt(sum(data_features.^2,2)));

projected_pca = norm_temp * pca_mapping;
itq_bin_mat = sign(max(projected_pca * itq_rot_mat,0));

end

