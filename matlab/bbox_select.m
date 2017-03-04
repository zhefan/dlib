close all
clear
clc


img_path = '/home/zhefanye/Documents/datasets/ProgressLab/img/tide_waterpot_salt_17/';
ext = 'png';
obj_list = {'tide', 'waterpot', 'salt'};

tracked_objs = cell(length(obj_list),1);

for i = 1:length(obj_list)
    disp(obj_list{i})
    tracked_objs{i} = get_tracked_pos(obj_list{i}, img_path, ext);
end

gen_xml(tracked_objs, img_path);