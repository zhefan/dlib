function gen_xml(tracked_objs, img_path, out_path, img_w, img_h)

if nargin < 5
    img_w = 640;
    img_h = 360;
    out_path = '/home/zhefanye/Documents/datasets/ProgressLab/progress/Annotations/';
end

C = strsplit(img_path, '/');
fname = C{end-1};

for i = 1:size(tracked_objs{1}.pos, 1)
    
    docNode = com.mathworks.xml.XMLUtils.createDocument('annotation');
    docRootNode = docNode.getDocumentElement;
    
    % folder
    thisElement = docNode.createElement('folder');
    thisElement.appendChild(docNode.createTextNode('progress'));
    docRootNode.appendChild(thisElement);
    
    % filename
    thisElement = docNode.createElement('filename');
    thisElement.appendChild(docNode.createTextNode(sprintf('%s_%i.png', fname, i)));
    docRootNode.appendChild(thisElement);
    
    % size
    thisElement = docNode.createElement('size');
    % width
    width = docNode.createElement('width');
    width.appendChild(docNode.createTextNode(sprintf('%i', img_w)));
    thisElement.appendChild(width);
    % height
    height = docNode.createElement('height');
    height.appendChild(docNode.createTextNode(sprintf('%i', img_h)));
    thisElement.appendChild(height);
    % depth
    depth = docNode.createElement('depth');
    depth.appendChild(docNode.createTextNode(sprintf('%i', 3)));
    thisElement.appendChild(depth);
    
    docRootNode.appendChild(thisElement);
    
    for j = 1:length(tracked_objs)
        
        tracked_pos = tracked_objs{j}.pos(i,:);
    
        % object
        thisElement = docNode.createElement('object');
        docRootNode.appendChild(thisElement);
        
        % name
        name = docNode.createElement('name');
        name.appendChild(docNode.createTextNode(tracked_objs{j}.name));
        thisElement.appendChild(name);
        
        % bndbox
        bndbox = docNode.createElement('bndbox');
        thisElement.appendChild(bndbox);
        
        % xmin
        xmin = docNode.createElement('xmin');
        xmin.appendChild(docNode.createTextNode( sprintf('%i', tracked_pos(1))));
        bndbox.appendChild(xmin);
        
        % ymin
        ymin = docNode.createElement('ymin');
        ymin.appendChild(docNode.createTextNode( sprintf('%i', tracked_pos(2))));
        bndbox.appendChild(ymin);
        
        % xmax
        xmax = docNode.createElement('xmax');
        xmax.appendChild(docNode.createTextNode( sprintf('%i', tracked_pos(3))));
        bndbox.appendChild(xmax);
        
        % ymax
        ymax = docNode.createElement('ymax');
        ymax.appendChild(docNode.createTextNode( sprintf('%i', tracked_pos(4)) ));
        bndbox.appendChild(ymax);
        
        
    end
        xmlFileName = [out_path fname, '_', int2str(i), '.xml'];
        xmlwrite(xmlFileName,docNode);
    
end