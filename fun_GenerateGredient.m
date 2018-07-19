function [gredient_I] = fun_GenerateGredient(I,flag)
%  Description: Generate Gredient along location (e.g. x axis or y axis)

% I: input gray image

mask_x = [0,  0, 0;
                   -1,0, 1;
                     0,0,0];
 
mask_xx = [0,  0, 0;
                   1,-2, 1;
                     0,0,0]./2;                
                 
 mask_y = [0,  -1, 0;
                    0,0, 0;
                     0,1,0];
                 
 mask_yy = [0,  1, 0;
                    0,-2, 0;
                     0,1,0]./2;
switch flag
    case 'x'
        mask = mask_x;
           case 'xx'
        mask = mask_xx; 
            case 'y'
        mask = mask_y;
            case 'yy'
        mask = mask_yy;

end
        gredient_I = filter2(mask,I,'same');


end