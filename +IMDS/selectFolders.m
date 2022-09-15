function imds_S = selectFolders(rootFolder, arraySelectedFolders, flagExclusion, labelsNames)
    % Select Folders to create an Image Datastore
    %
    %% Description:
    % This function is part of IMDS and creates an imageDatastore, specifying the
    %  folders to be used to select images.
    %
    %% Syntax:
    %    imds = selectFolders(rootFolder, arraySelectedFolders);
    %       selects the subdirectories of rootFolder whose names include
    %       the strings specified in arraySelectedFolders.
    %
    %    imds = selectFolders(rootFolder, arraySelectedFolders, false);
    %       IDEM
    %
    %    imds = selectFolders(rootFolder, arraySelectedFolders, true);
    %       selects the subdirectories to EXCLUDE from rootFolder whose 
    %       name contains the strings specified in arraySelectedFolders.
    %
    %    imds = selectFolders(rootFolder, arraySelectedFolders, flagExclusion, labelsNames);
    %       depending on the value of flagExclusion, the subdirectories will be
    %       included (false) or excluded (true) to create the imageDatastore. 
    %       labelsNames will be used to rename the classes of the imageDatastore.
    %       - If labelsNames is a single string of characters, all selected images
    %           in the Datastore will be labelled with this single label.
    %       - If labelsNames is an array of labels, the classes consisting of the
    %           various directories will be renamed (in order).
    %
    %% Input: 
    %    rootFolder [string]: path of the Root Directory where to find the images 
    %    arraySelectedFolders [array]: array containing the names of the 
    %               subdirectories to selected. The directories contained in 
    %               the rootFolder will be selected if their name contains 
    %               one of the proposed strings in arraySelectedFolders.
    %    flagExclusion [boolean]: boolean to active the exclusion option
    %               - false by default == the selected list corresponds to
    %                                       an inclusion of Folders
    %               - true == the selected list is a Folders exclusion
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
    %

    %% Code 
    % Par défaut, Inclusion des Folders
    if nargin<3
        flagExclusion = false;  % false == la liste correspond aux répertoires inclus, sinon la liste correspond aux répertoires exclus
    end
    % Par défaut, pas de renommage des labels
    if nargin<4
        labelsNames = [];
    end
    %  =----= Files =----=
    IMDS = imageDatastore(rootFolder,"IncludeSubfolders",true,"LabelSource","foldernames");
    listClasses = string(countEachLabel(IMDS).Label);
    new_listClasses = strings(numel(arraySelectedFolders),1);
    for iE=1:numel(arraySelectedFolders)
        searchFolder = strrep(arraySelectedFolders(iE),' ','_');
        if flagExclusion % Exclusion
            listClasses = listClasses(~contains(listClasses,searchFolder,'IgnoreCase',true));
        else % Inclusion
            new_listClasses(iE) = listClasses(contains(listClasses,searchFolder,'IgnoreCase',true));
        end          
    end
    %
    if ~flagExclusion % Inclusion
        listClasses = new_listClasses;       
    end
    listDir = string(rootFolder) + listClasses;
    %
    %  =----= Labels =----=
    if ~isempty(labelsNames)
        imds_S = imageDatastore(listDir);
        if isstring(labelsNames)
            if numel(labelsNames)==1 % Si un seul label est donnée => on affecte ce label à toutes les images du datastore
                imds_S.Labels = categorical(repelem(labelsNames,numel(imds_S.Files)));
            else % Sinon, on renomme les labels pour lesquels (dans l'ordre) on a fourni un nouveau nom (les autres ne sont pas renommés)
                new_imds = imageDatastore(listDir,"LabelSource","foldernames");
                imds_S.Labels = new_imds.Labels;
                 %
                 for ilN=1:numel(labelsNames)
                    %
                    ind_C = new_imds.Labels==listClasses(ilN);
                    if ~isempty(char(labelsNames(ilN)))
                        imds_S.Labels(ind_C)=categorical(labelsNames(ilN));
                    end
                end
            end
        end
    else % Si aucun nom de labels est donné, on utilise les noms des répertoires
        imds_S = imageDatastore(listDir,"LabelSource","foldernames");
    end
    %
end
