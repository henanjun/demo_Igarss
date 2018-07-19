
function [colorAll] =fun_ColorGradient(I)
[m,n,b] = size(I);
for i = 1:b
    band = double(I(:,:,i));
    colortmp(:,:,1) = double(band);
    colortmp(:,:,2) = abs(fun_GenerateGredient(band,'x'));
    colortmp(:,:,3) = abs(fun_GenerateGredient(band,'y'));
    colortmp(:,:,4) = abs(fun_GenerateGredient(band,'xx'));
    colortmp(:,:,5) = abs(fun_GenerateGredient(band,'yy'));
    colorAll(:,:,(i-1)*5+1:i*5) = colortmp;
end
end