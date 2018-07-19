clc;clear;
I = imread('airplane00.tif');

% [gabor_cov, im_gabor_3d] =fun_GaborCov(I);

% [ColorLocationCov] =fun_ColorLocationCov(I)
 
 [gabor_cov, im_gabor_3d,im_color] =fun_GaborColorCov(I);
 for i = 1:size(im_gabor_3d,3)
     tmp = im_gabor_3d(:,:,i);
     name = ['gabor-',num2str(i),'.jpg'];
     imwrite(uint8(tmp),name);
 end
 
 for i = 1:size(im_color,3)
     tmp = im_color(:,:,i);
     name = ['color-',num2str(i),'.jpg'];
     imwrite(uint8(tmp),name)
 end