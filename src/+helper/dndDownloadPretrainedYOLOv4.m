function model = dndDownloadPretrainedYOLOv4(basePath, modelName)
% The downloadPretrainedYOLOv4 function downloads a YOLO v4 network 
% pretrained on COCO dataset.
%
% Copyright 2021 The MathWorks, Inc.

supportedNetworks = ["YOLOv4-coco", "YOLOv4-tiny-coco"];
validatestring(modelName, supportedNetworks);

dataPath = basePath;
netFileFullPath = fullfile(dataPath, modelName + '.zip');
weightsFile = fullfile(dataPath, modelName + '.mat');

if ~exist(netFileFullPath,'file')
    fprintf('Downloading pretrained '+ modelName +' network.\n');
    fprintf('This can take several minutes to download...\n');
    url = 'https://ssd.mathworks.com/supportfiles/vision/deeplearning/models/yolov4/'+modelName+'.zip';
    websave(netFileFullPath, url);
    fprintf('Done.\n\n');
    unzip(netFileFullPath, dataPath);
    model = load(fullfile(dataPath , modelName + '.mat'));
else
    fprintf('Pretrained '+ modelName+ ' network already exists.\n\n');
    if exist(weightsFile, 'file')
        model = load(weightsFile);
    else
        unzip(netFileFullPath, dataPath);
        model = load(fullfile(dataPath , modelName + '.mat'));
    end
end
model = layerGraph(model.net);
end
