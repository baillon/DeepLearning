function imds_B = balanceImageDatastore(imds,numDesired)
    % Balance Image Datastore
    %
    %% Description:
    % This function is part of IMDS and balances the classes of an imageDatastore,
    % replicating if necessary the images already present in each class to
    %  to reach the desired number of images.
    %
    %% Syntax:
    %    imds_B = balanceImageDatastore(imds);
    %        balances the classes of the imageDatastore, so that each class
    %        has the maximum number of images observed in the original imageDatastore
    % 
    %    imds_B = balanceImageDatastore(imds, valNum);
    %        balances the classes of the imageDatastore, so that each class
    %        has the number of images valNum
    % 
    %    balanceImageDatastore(imds, valNum);
    %        if there is no imageDatastore specified for the output, the
    %        the first input will be modified.
    %
    %% Input: 
    %    imds [imageDatastore]: imageDatastore
    %    valNum [integer] (optional): number of images desired per class 
    %
    %% Output:
    %   imds_B [imageDatastore]:  Balanced imageDatastore
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
    % par défaut, on complète les classes pour atteindre le nombre maximal
    % observé parmis toutes classes
    if nargin<2
        numDesired = max(countEachLabel(imds).Count);
    end
    % dans G == numéro correspond à une classe
    [G,classes] = findgroups(imds.Labels);
    % on regroupe les fichiers par classes d'appartenance
    files = splitapply(@(x) {x},imds.Files,G);
    new_files = cell(numel(classes), 1);
    new_labels = cell(numel(classes), 1);
    % pour chaque classe
    for iF = 1:numel(classes)
        % on sélectionne les fichiers pour cette classe
        new_files{iF,1} = randReplicateFiles(files{iF,1},numDesired);        
        % on labélise tous les fichiers de cette classe (anciens comme nouveaux)
        new_labels{iF,1} = repmat(classes(iF),numDesired,1);
    end
    % on concataine les anciens et les nouveaux fichiers
    files = vertcat(new_files{:});
    labels = vertcat(new_labels{:});
    % on crée un nouveau imageDatastore
    imds_B = imageDatastore(files, "Labels",labels);
    %
    if ~nargout
        assignin('base',inputname(1),imds_B)
    end
    %
    % =-=-=-=-=-=-=-=-=
    function new_files = randReplicateFiles(files,numDesired)
        % cette fonction créé une nouvelle liste de fichiers new_files en complétant
        % celle passée en entrée files, par autant de fichiers nécessaires (tirés
        % au hasard parmi files), pour atteindre le nombre de fichiers désiré numDesired
        %
        n = numel(files);
        if numDesired > n
            % on ajoute le complément d'indices nécessaire pour atteindre le
            % nombre d'images désiré
            new_ind = randi(n,numDesired-n,1);
            ind = [(1:n)';new_ind];
        else
            ind = (1:numDesired)';
        end
        new_files = files(ind);
    end
    %
end
