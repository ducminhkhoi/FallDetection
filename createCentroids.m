function [ output_args ] = createCentroids( database, sheet_train )
%CREATECENTROIDS Summary of this function goes here
%   Detailed explanation goes here

    [~, ~, train_files] = xlsread(database, sheet_train);
    all_train_videos = train_files(:,1);

    time = train_files(:,3:4);
 
    X = getX_train(all_train_videos, time);
    
    k = 1:200;
    SSE = zeros(length(k), 1);
    MSE = zeros(length(k), 1);
    
    for i = 1:length(k)
        k(i);
        MSE(i) = K_means(X, k(i)); 
        SSE(i) = MSE(i) * k(i);
    end
     
    figure;
    plot(k, SSE);
    xlabel 'Number of k'
    ylabel 'SSE'
    title 'relation between k and SSE'
end

