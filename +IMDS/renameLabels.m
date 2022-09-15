function imds_S = renameLabels(imds, old_arrayLabels, new_arrayLabels)
    % Rename Labels of an Image Datastore
    %
    %% Description:
    % This function is part of IMDS and allows you to rename the classes of
    % an imageDatastore, by specifying new labels to replace the old ones labels.
    %
    %% Syntax:
    %    imds_S = renameLabels(imds, old_arrayLabels, new_arrayLabels);
    %       the label classes contained in old_arrayLabels will be renamed
    %       to carry the labels specified (in the same order) in new_arrayLabels.
    %
    %    renameLabels(imds, old_arrayLabels, new_arrayLabels);
    %       if there is no imageDatastore specified for the output, 
    %       the input one will be changed.
    %
    %% Input:
    %    imds [imageDatastore]: input  imageDatastore
    %    old_arrayLabels [string array]: array containing the old names 
    %       of the imageDatastore classes
    %    new_arrayLabels [string array]: array containing new imageDatastore
    %       class names 
    %
    %% Output:
    %   imds_S [imageDatastore]:  output imageDatastore
    %
    %% Disclaimer:
    %   Last editor : Fabien Baillon
    %   Last edit on: 10.01.2022
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
    imds_S = imds;
    for iL = 1:numel(new_arrayLabels)
        imds_S.Labels(imds_S.Labels==old_arrayLabels(iL)) = new_arrayLabels(iL);
    end
    if ~nargout
        assignin('base',inputname(1),imds_S)
    end
end
