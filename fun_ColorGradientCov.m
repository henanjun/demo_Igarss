
function [ColorLocationCov] =fun_ColorGradientCov(I)
[m,n,~] = size(I);
gray_img = rgb2gray(I);
colorLoc = zeros(m,n,10);
row_loca = [1:m]';
colmn_loca = 1:n;
colorLoc(:,:,1) = row_loca*ones(1,n);
colorLoc(:,:,2) = ones(m,1)*colmn_loca;
colorLoc(:,:,3:5) = double(I);
colorLoc(:,:,6) = abs(fun_GenerateGredient(gray_img,'x'));
colorLoc(:,:,7) = abs(fun_GenerateGredient(gray_img,'y'));
colorLoc(:,:,8) = abs(fun_GenerateGredient(gray_img,'xx'));
colorLoc(:,:,9) = abs(fun_GenerateGredient(gray_img,'yy'));
angel = abs(atan(colorLoc(:,:,7)./colorLoc(:,:,6)));
angel(isnan(angel)) = 0;
colorLoc(:,:,10) = abs(angel);

for i = 1:10
    aul1 = colorLoc(:,:,i);
    name = [num2str(i),'.png'];
    aul1= scaling(aul1)*255;
    imwrite(uint8(aul1),name);
end

colorLoc_new = colorLoc(:,:,3:9);
tmp_mat = reshape(colorLoc_new, m*n,7)';
mean_mat = mean(tmp_mat,2);
centered_mat = tmp_mat-repmat(mean_mat,1,size(tmp_mat,2));
tmp = centered_mat*centered_mat'/((size(tmp_mat,2))-1);
tol = 1e-3;
ColorLocationCov = logm(tmp+tol*trace(tmp)*eye(size(tmp)));
end