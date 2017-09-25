function [ model ] = SVM_training(k, window_size, kernel_function, list_videos, time)
%TRAIN_HMM Summary of this function goes here
%   Detailed explanation goes here
    
    % Begin Modified data
    X = [];
    Y = [];
    d = ceil((window_size-1)/2);
    load (['model/kmeans/Centroid_' num2str(k) '.mat'], 'C')
    
    for index3 = 1:size(list_videos,1)
        video_name = list_videos{index3}
        X_raw = getX_train({video_name}, time(index3,:));

        INX = [];
        for index4 = 1:size(X_raw,1)
            D = distfun(C,X_raw(index4,:));	% Calculate the distance from each feature to the centroids.
            INX = [INX find(D==min(D))];		    % Add index to each frame.
        end

        for i = d+1:size(X_raw,1)-d
            X = [X; INX(i-d:i+d)];
            if strcmp(video_name(end-4),'F')  % Fall
                Y = [Y; 1];
            else
                Y = [Y; 0];
            end
        end
    end
    % End modified data
    
    if strcmp(kernel_function, 'polynomial')
        model = fitcsvm(X, Y, 'KernelFunction', kernel_function, 'PolynomialOrder', 2);
    else
        model = fitcsvm(X, Y, 'KernelFunction', kernel_function);
    end
    
end

