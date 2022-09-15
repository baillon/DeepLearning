function imds_I = includeFolders(rootFolder, arraySelectedFolders, labelName_I)
    % Include Folders to create an Image Datastore
    %
    %% Description:
    % This function is part of IMDS and creates an imageDatastore, specifying the
    %  folders to be included for selecting images.
    %
    %% Syntax:
    %    imds = includeFolders(rootFolder, arraySelectedFolders);
    %       subdirectories of rootFolder whose names include the strings
    %       specified in arraySelectedFolders will be included
    %       in the imageDatastore
    %
    %    imds = includeFolders(rootFolder, arraySelectedFolders, labelsNames);
    %       subdirectories will be included to create the imageDatastore. 
    %       labelsNames will be used to rename the classes in the
    %       imageDatastore.
    %       - If labelsNames is a single string of characters, all selected 
    %           images in the Datastore will be labelled with this single label.
    %       - If labelsNames is an array of labels, the classes consisting of
    %           the various directories will be renamed (in order).
    %
    %% Input: 
    %    rootFolder [string]: path of the Root Directory where to find the images 
    %    arraySelectedFolders [array]: array containing the names of the 
    %               subdirectories to selected. The directories contained in 
    %               the rootFolder will be included if their name contains 
    %               one of the proposed strings in arraySelectedFolders.
    %    labelsNames [string array]: single label or array of labels to rename
    %               the classes of the imageDatastore
    %
    %% Output:
    %   imds [imageDatastore]:  output imageDatastore
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
    
    %% Code 
    %
    if nargin<3
        labelName_I = [];
    end
    %
    imds_I = IMDS.selectFolders(rootFolder, arraySelectedFolders, false, labelName_I);
end
%
