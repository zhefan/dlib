close all
clear
clc

img_path = '../examples/test_frames/';
img_dir = dir([img_path '*.png']);

first_img = imread([img_path img_dir(1).name]);
figure, imshow(first_img);
h = imrect;
pos = round(wait(h));

command = ...
    sprintf('cd ../python_examples && python test_tracker.py %d %d %d %d',...
    pos(1), pos(2), pos(1)+pos(3)-1, pos(2)+pos(4)-1);
[status, cmdout] = system(command,'-echo');
cmdout = strrep(cmdout, '[(', '');
cmdout = strrep(cmdout, ')]', '');
cmdout = strrep(cmdout, '(', '');
cmdout = strrep(cmdout, ')', '');
cmdout = strrep(cmdout, ',', '');
C = strsplit(cmdout, '\n');
tracked_pos = [];
for i =1:length(C)
    if ~isempty(C{i})
        D = textscan(C{i}, '%d %d %d %d');
        temp_arr = cell2mat(D);
        temp_arr = [max(1, temp_arr(1)), max(1, temp_arr(2)),...
            min(size(first_img,2), temp_arr(3)),...
            min(size(first_img,1), temp_arr(4))];
        tracked_pos = [tracked_pos; cell2mat(D)];
    end
end
if size(tracked_pos,1) ~= length(img_dir)
    error('size mismatch')
end