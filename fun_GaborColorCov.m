
function [gaborcolor_cov,im_gabor_3d,im_color_gradient] =fun_GaborColorCov(I)
% I: input RGB image
% gaborcolor_cov: output encodeded feature using covariance pooling (gabor feature and color feature)
% im_gabor_3d: Gabor feature, im_color_gradient: color gradient feature (For observation)
% written by: Nanjun He(hunanjun@hnu.edu.cn)


[m,n,~] = size(I);
scales_gabor = 1:1:10;
angles_gabor = [30 60 90 120 150 180];
temp1 = length(scales_gabor);
temp2 = length(angles_gabor);
im_gabor_3d = zeros(m,n,temp1*temp2);
grayI = rgb2gray(I);
id = 1;
for i = 1:1:temp1
    for j = 1:1:temp2
        [NaN1, NaN2, temp] = spatialgabor(grayI,scales_gabor(i),angles_gabor(j),0.5,0.5,1);
        im_gabor_3d(:,:,id) = temp;
        id = id+1;
    end
end
im_gabor_3d_extend = zeros(m,n,temp1*temp2+15);% additional 15 feature maps are color feature maps
im_gabor_3d_extend(1:m,1:n,1:temp1*temp2) =  im_gabor_3d;
im_color_gradient = fun_ColorGradient(I);
im_gabor_3d_extend(1:m,1:n,temp1*temp2+1:temp1*temp2+15) = im_color_gradient;
tmp_mat = reshape(im_gabor_3d_extend, m*n,temp1*temp2+15)';
n = size(tmp_mat,2);
aul = randperm(n);
id_rand = aul(1:ceil(n/3));
tmp_mat = tmp_mat(:,id_rand);
[tmp_mat] = L2norm(tmp_mat);
mean_mat = mean(tmp_mat,2);
centered_mat = tmp_mat-repmat(mean_mat,1,size(tmp_mat,2));
tmp = centered_mat*centered_mat'/((size(tmp_mat,2))-1);
tol = 1e-3;
tmp = tmp+tol*trace(tmp)*eye(size(tmp));
gaborcolor_cov = logm(tmp);
end