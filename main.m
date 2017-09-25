clear all;
% Set up variables
methods = {'hmm', 'svm'};
method = methods{2}; % choose method
k = 40; % number of cluster
database = 'Database.xls';
sheet_test = 'WMTestData';
sheet_train = {'train', 'trainNonFall'}; %'train_official';

if strcmp(method, 'hmm')
    parameter = 30;
else
    parameter = 10;
end

%% create centroids from kmeans
% createCentroids;

%% Train and validate data to choose best parameter
result = zeros(4,2);
for i = 1:length(methods)
    method = methods{i}; % choose method
    
    if strcmp(method, 'hmm')
        parameter = 30;
    else
        parameter = 10;
    end
    
    % Train data
    train_model(method, parameter, database, sheet_train, k);

    % Test data
    [Precision, Recall, F1, Accuracy] = test_model(method, parameter, database, sheet_test, k);
    
    result(:,i) = [Precision, Recall, F1, Accuracy]';
end

figure;
name = {'Precision';'Recall';'F1';'Accuracy'};
bar(result)
legend('HMM', 'SVM');
title 'compare result betwen HMM and SVM'
set(gca,'xticklabel',name)