function [ X ] = getX_train( list_videos, time)
%GETX Summary of this function goes here
%   Detailed explanation goes here
    X = [];

    for i_out = 1:length(list_videos)
        video_name = list_videos{i_out};
        video_name(end-3:end) = '.mat';
        
        % get 5 features from image
        load (['train_data' filesep 'five_features' filesep video_name], 'ArrayFeature');

        if ~strcmp(video_name(end-4), '1')  
            % get extended features from image!      
            load (['train_data' filesep 'extended_features' filesep video_name], 'Df', 'mean_C');

            start_time = cell2mat(time(i_out,1));
            end_time = cell2mat(time(i_out,2));
            extended_features = [Df(start_time:end_time)' mean_C(start_time:end_time)'];  
        else           
            video_name(end-4) = [];
            
            % get extended features from image!      
            load (['train_data' filesep 'extended_features' filesep video_name], 'Df', 'mean_C');

            start_time_1 = cell2mat(time(i_out,1));
            end_time_1 = cell2mat(time(i_out,2));
            start_time_2 = cell2mat(time(i_out,3));
            end_time_2 = cell2mat(time(i_out,4));
            
            temp_1 = [Df(start_time_1:end_time_1)' mean_C(start_time_1:end_time_1)'];
            temp_2 = [Df(start_time_2:end_time_2)' mean_C(start_time_2:end_time_2)'];
            extended_features = [temp_1; temp_2];
        end
        
        try
            X = [X; [ArrayFeature extended_features]];
        catch e
            e
        end
        
    end
    
    X(:,1) = log(X(:,1)+1)/log(40);
    X(:,2) = log(X(:,2)+1)/log(30);
    X(:,4) = abs((X(:,4)-45)/90);
end

