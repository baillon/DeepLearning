function imds_S = fuseClasses(imds, labelName, numImages)
    % Fuse all classes of an Image Datastore
    %
    %% Description:
    % This function is part of IMDS and merges all classes in an imageDatastore,
    % naming the resulting class according to the specified labelName.
    % - If a desired number of images in the resulting class is specified
    %    the classes are rebalanced accordingly before merging.
    %
    %% Syntax:
    %    imds_F = fuseClasses(imds, labelName);
    %       merges the classes in the imageDatastore, and names the
    %       resulting class labelName.
    %
    %    imds_F = fuseClasses(imds, labelName, numImages);
    %       merges the imageDatastore classes, so that the resulting
    %       class labelName has the number of images numImages (the
    %       different original classes are represented fairly).
    %
    %    fuseClasses(imds, labelName, numImages);
    %       if there is no imageDatastore specified for the output, the
    %       the input one will be modified.
    %
    %% Input:
    %    imds [imageDatastore]: input  imageDatastore
    %    labelName [string]: label of the resulting class
    %    numImages [integer]: desired number of images per class
    %
    %% Output:
    %   imds_F [imageDatastore]:  output imageDatastore
    %
    %% Disclaimer:
    %   Last editor : Fabien Baillon
    %   Last edit on: 12.12.2021
    %
    %   Copyright (c) 2021-2022 Fabien Baillon.
    %
    %   This file is part of IMDS.
    %
    %   IMDS is free software: you can redistribute it and/or modify
    %   it under the terms of the GNU General Public License as published by
    %   the Free Software Foundation, either version 3 of the License, or
    %   any later version. Also see the file "License.mlx".
    %

    %% Code 
    if nargin<3
        imds_S = imds;
    else
        numClasses = numel(unique(imds.Labels));
        numImagesPerClasses = ceil(numImages/numClasses);
        imds_S = shuffle(IMDS.balancedIMDS(imds,numImagesPerClasses));
        imds_S.Files = imds_S.Files(1:numImages);
    end
    imds_S.Labels = categorical(repelem(labelName,numel(imds_S.Files)));
    if ~nargout
        assignin('base',inputname(1),imds_S)
    end

end
