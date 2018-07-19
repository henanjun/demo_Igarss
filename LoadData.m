
function imdb_all = LoadData(rt_img_dir,img_type)
subfolders = dir(rt_img_dir);
count1 = 1; 
count2 = 1;
label = [];
% begin read the name of  all images
for ii = 1:length(subfolders)
    subname = subfolders(ii).name;
    if ~strcmp(subname, '.') & ~strcmp(subname, '..')
        frames = dir(fullfile(rt_img_dir, subname,img_type));
        c_num = length(frames);
        class_name{count2} = subname;
        label = [label, ones(1,c_num)*count2];
        count2 = count2+1;
        for jj= 1:c_num
            allsamples_path{count1} = fullfile(rt_img_dir, subname, frames(jj).name);
            count1 = count1+1;
        end
     end
end
imdb_all.allsamples_name = allsamples_path;
imdb_all.class_name = class_name;
imdb_all.label = label;
% name = ['imdb_all',data_set_name];
% save(name,'imdb_all');
end