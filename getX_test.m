function [ X ] = getX_test(video_name)
%GETX Summary of this function goes here
%   Detailed explanation goes here

    video_name(end-3:end) = '.mat';
    % get 5 features from image
    load (['test_data' filesep video_name], 'ArrayFeature');
    ArrayFeature = ArrayFeature(15:end,:);

    % get extended features from image!
    load (['train_data' filesep 'extended_features' filesep video_name], 'Df', 'mean_C');

    extended_features = [Df' mean_C'];

    X = [ArrayFeature extended_features];   
    
    X(:,1) = log(X(:,1)+1)/log(40);
    X(:,2) = log(X(:,2)+1)/log(30);
    X(:,4) = abs((X(:,4)-45)/90);
end

