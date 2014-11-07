function [ itq_bin_mat ] = test_itq( data_features, itq_rot_mat, pca_mapping, mean_data )
% Mapp feature vectors to itq binreies
%
%   input:
%       -data_features : feature vectors
%       -itq_rot_mat : ITQ rotation matrix
%       -pca_mapping : PCA eigen vectors
%
%   output:
%       -itq_bin_mat: feature vectors mapped binaries.

if (nargin<4) || isempty(mean_data)
  mean_data = mean(data_features);
end

data_features=bsxfun(@minus,data_features,mean_data);
norm_temp=bsxfun(@rdivide,data_features,sqrt(sum(data_features.^2,2)));

projected_pca = norm_temp * pca_mapping;
itq_bin_mat = sign(max(projected_pca * itq_rot_mat,0));

end

