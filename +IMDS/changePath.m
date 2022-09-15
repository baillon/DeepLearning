function imds_S = changePath(imds, old_rootFolder, new_rootFolder)
    % Change path in  an Image Datastore
    %
    %% Description:
    % This function is part of IMDS and allows you to change the paths to the files
    % in an imageDatastore, by specifying a new string that should
    % replace the old one.
    %
    %% Syntax:
    %   imds_S = changePath(imds, old_rootFolder, new_rootFolder);
    %       the paths to the files in the datastore will be changed by
    %       replacing the old string old_rootFolder with the new new_rootFolder.
    %
    %   changePath(imds, old_rootFolder, new_rootFolder);
    %       if there is no imageDatastore specified for the output,
    %       the input one will be changed.
    %
    %% Input: 
    %    imds [imageDatastore]: imageDatastore
    %    old_rootFolder [string]: string of the path to the datastore files 
    %    new_rootFolder [string]: string for the target path 
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
    imds_S.Files= cellfun(@(x) strrep(x,old_rootFolder,new_rootFolder),imds.Files);
    if ~nargout
        assignin('base',inputname(1),imds_S)
    end
end
