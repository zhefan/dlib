function bbox_select(obj_list, img_path, ext, img_w, img_h)

close all
clc

if nargin < 5
    obj_list = {'spray_bottle_a', 'detergent', 'clorox'};
    img_path = '/home/zhefanye/Documents/datasets/ProgressLab/img/sdc_10/';
    ext = 'png';
    img_w = 640;
    img_h = 360;
end

tracked_objs = cell(length(obj_list),1);

for i = 1:length(obj_list)
    disp(obj_list{i})
    tracked_objs{i} = get_tracked_pos(obj_list{i}, img_path, ext);
end

prompt = 'Do you want to continue? y/n [y]: ';
str = input(prompt,'s');
if isempty(str)
    str = 'y';
end

if strcmp(str, 'y')
    fprintf('Writing annotations...')
    gen_xml(tracked_objs, img_path, img_w, img_h);
end

end