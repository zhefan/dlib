function gen_xml(tracked_obj, img_w, img_h)

tracked_pos = tracked_obj.pos;

for i = 1:size(tracked_pos, 1)
    line = input_file(i, :);
    disp(line)
    
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
    
    % object
    thisElement = docNode.createElement('object');
    docRootNode.appendChild(thisElement);
    
    % name
    name = docNode.createElement('name');
    name.appendChild(docNode.createTextNode(C{1}));
    thisElement.appendChild(name);
    
    % bndbox
    bndbox = docNode.createElement('bndbox');
    thisElement.appendChild(bndbox);
    
    % xmin
    xmin = docNode.createElement('xmin');
    xmin.appendChild(docNode.createTextNode( sprintf('%i', line(2)) ));
    bndbox.appendChild(xmin);
    
    % ymin
    ymin = docNode.createElement('ymin');
    ymin.appendChild(docNode.createTextNode( sprintf('%i', line(3)) ));
    bndbox.appendChild(ymin);
    
    % xmax
    xmax = docNode.createElement('xmax');
    xmax.appendChild(docNode.createTextNode( sprintf('%i', line(2)+line(4)) ));
    bndbox.appendChild(xmax);
        
    % ymax
    ymax = docNode.createElement('ymax');
    ymax.appendChild(docNode.createTextNode( sprintf('%i', line(3)+line(5)) ));
    bndbox.appendChild(ymax);   
    
    xmlFileName = [out_path fname, '_', int2str(i), '.xml'];
    xmlwrite(xmlFileName,docNode);    
    
end