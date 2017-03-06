function bbox_select(obj_list, img_path, ext, img_w, img_h)

if nargin < 5
    obj_list = {'tide', 'waterpot', 'salt'};
    img_path = '/home/zhefanye/Documents/datasets/ProgressLab/img/tws_21/';
    ext = 'png';
    img_w = 640;
    img_h = 360;
end

tracked_objs = cell(length(obj_list),1);

for i = 1:length(obj_list)
    disp(obj_list{i})
    tracked_objs{i} = get_tracked_pos(obj_list{i}, img_path, ext);
end

gen_xml(tracked_objs, img_path, img_w, img_h);

end