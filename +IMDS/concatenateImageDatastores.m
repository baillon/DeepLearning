function imds_C = concatenateImageDatastores(varargin)
    % Concatenate Image Datastores
    %
    %% Description:
    % This function is part of IMDS and allows you to concatenate imageDatastores.
    %
    %% Syntax:
    %    imds = concatenateImageDatastore(cell_IMDS);
    %       creates a new imageDatastore, concatenating the imageDatastores
    %       specified in a cell
    %
    %    imds = concatenateImageDatastore(imds1, imds2, ...);
    %       creates a new imageDatastore, concatenating the imageDatastores
    %       listed as input arguments
    %
    %% Input: 
    %    cell_IMDS [cell]: cell of imageDatastores
    % or
    %    imds1, imds2, ...  [imageDatastore]: imageDatastores
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
    %

    %% Code 
    if nargin > 1
      listIMDS = varargin;
   else % si une seule entrée => cell de IMDS
      listIMDS = varargin{1};
   end
   n_IMDS = numel(listIMDS);
   Files = cell(n_IMDS,1);
   Labels = cell(1,n_IMDS);
   for i = 1:n_IMDS
      Files{i} = listIMDS{i}.Files;
      Labels{i} = listIMDS{i}.Labels;
   end
   imds_C = imageDatastore(cat(1, Files{:}));
   imds_C.Labels = categorical(cat(1, Labels{:}));
end
