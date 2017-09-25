function [ Precision, Recall, F1, Accuracy ] = validate(method, parameter, database, sheet_test, k)
    %%   Read name of the database from file Excel
    [~, ~, test_files] = xlsread(database, sheet_test);
    all_test_videos = test_files(:,1);
    trueClass = test_files(:,2);
    range = length(all_test_videos);

    %% Initial variables
    P = 0; N = 0;
    result = zeros(1,range);

    %% Calculate the amount of fall and non-fall actions based on the database.
    for index1= 1:range
        ins = char(trueClass(index1));
        if strcmp(ins, 'Fall')
            result(index1) = 1;
            P = P + 1;
        else 
            result(index1) = 0;
            N = N + 1;
        end
    end


    %% Test

    % intialize value
    classify = zeros(1,range);
    
    list_fall_videos = [];
    list_non_fall_videos = [];

    for index2= 1:range
        tic;
        file_name = all_test_videos{index2};
        
        if strcmp(method, 'hmm')
            [classify(index2), output] = HMM_testing(k, parameter, file_name);
        elseif strcmp(method, 'svm')
            kernel_function = 'gaussian';
            [classify(index2), output] = SVM_testing(k, file_name, kernel_function, parameter);
        end
        
        if strcmp(file_name(end-4),'F')
            list_fall_videos = [list_fall_videos; output];
        else
            list_non_fall_videos = [list_non_fall_videos; output];
        end
    end
    
    
    %% Evaluate the system based on ROC
    TP = sum(and(classify,result));
    FP = sum(and(classify,not(result)));
    TN = N - FP;

    Recall = TP/P
    Precision = TP/(TP+FP)
    F1 = 2*Recall*Precision/(Recall + Precision)
    Accuracy = (TP+TN)/(P+N)
end

