function previewClasses(imds, numDesired, selClasses)
    % Fuse all classes of an Image Datastore
    %
    %% Description:
    % This function is part of IMDS and displays a preview of a given number
    % of images contained in the classes of an imageDatastore.
    % For each image displayed, the preview specifies its class, its
    % index in the imageDatastore, and its definition.
    %
    %% Syntax:
    %    previewClassesIMDS(imds);
    %       displays a default preview of all classes.
    %
    %    previewClassesIMDS(imds, valNum);
    %       displays a preview of valNum images per class, for all classes.
    %
    %    previewClassesIMDS(imds, valNum, selector);
    %       displays a preview of valNum images per class, for the classes
    %       corresponding to the selector.
    %
    %    previewClassesIMDS(imds, [], selector);
    %       displays a default preview, for classes matching the selector.
    %
    %% Input:
    %    imds [imageDatastore]: input  imageDatastore
    %    valNum [integer]: number of images to display (default value ==3 )
    %    selector [string]: numeric, string, or string cell values
    %       - numeric values correspond to class numbers in alphabetical order
    %       - the character strings correspond to the full or partial names
    %           of classes.
    %
    %% Output:
    %    [-]
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
    %
    % on détermine l'appartenance aux différentes classes
    [G,classes] = findgroups(imds.Labels);
    % par défaut, on affichera 3 images par classe
    if nargin<2 || isempty(numDesired)
        numDesired = 3;
    end
    % par défaut, toutes les classes seront affichées
    if nargin<3
        selClasses = classes;
    end
    % conversion de l'entrée selClasses en categorical array, contenant le
    % nom des classes sélectionnées pour l'affichage
    switch class(selClasses)
        case 'char'
            selClasses = categorical({selClasses});
        case 'string'
            selClasses = categorical({char(selClasses)});
        case 'cell'
            selClasses = categorical(selClasses);
        case 'double'
            selClasses = classes(selClasses);
    end
    % pour chaque classe sélectionnée
    for iC = 1:numel(selClasses)
        %
        SelClass = string(selClasses(iC));

        % Ce tableau indexSel comprend tous les indices des classes correspondant à
        % la chaine de caractères sélectionnée
        indexSel = find(contains(string(classes),SelClass));
        if ~isempty(indexSel)
            for i=1:numel(indexSel)
                sel_G = find(G==indexSel(i));
                num_Images = min(numDesired, numel(sel_G));
                adaptedLayout(num_Images);
                indRandom = randperm(numel(sel_G),num_Images);
                for iI = 1:num_Images
                    nexttile;
                    indImage = sel_G(indRandom(iI));
                    [img, info] = imds.readimage(indImage);
                    imshow(img);
                    title({string(info.Label)+" [n° "+indImage+"]",strjoin(string(size(img)),'x')}, "interpreter", "none");
                end
            end
        else
            fprintf("la classe %s n'existe pas dans l'IMDS !",SelClass)
        end
    end
    % =-=-=-=-=-=-=-=-=
    function adaptedLayout(numImages)
        persistent flagColor
        flagColor = isempty(flagColor) || ~flagColor;
        bgColors = ["#EEEEEE","#EEFFFF"];
        % définit un facteur de forme adapté selon le nombre d'images à
        % afficher
        if numImages <4
            nCol = numImages; nLig = 1;
        else
            nCol = min(4,ceil(sqrt(numImages)));
            nLig = ceil(numImages/nCol);
        end
        figure("Color",bgColors(flagColor+1));
        tiledlayout(nLig, nCol,"TileSpacing","compact","Padding","tight");
    end
%
end
