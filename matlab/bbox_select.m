function bbox_select(obj_list, img_path, ext, img_w, img_h)

close all
clc

if nargin < 5
    obj_list = {'downy', 'sugar', 'red_bowl'};
    img_path = '/home/zhefanye/Documents/datasets/ProgressLab/img/dsr_290/';
    ext = 'png';
    img_w = 640;
    img_h = 360;
end

dataset_img = '/home/zhefanye/Documents/datasets/ProgressLab/progress/JPEGImages/';
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
    fprintf('Writing annotations...\n')
    gen_xml(tracked_objs, img_path, img_w, img_h);
    
    command = sprintf('cp %s*.%s %s', img_path, ext, dataset_img);
    system(command,'-echo');
    fprintf('Copying images...\n')    
end

end