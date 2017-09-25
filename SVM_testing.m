function [Detect, output] = SVM_testing(k, file_name, kernel_function, window_size)
%   TESTANN Test each video using trained ANN.
    
    load (['model/kmeans/Centroid_' num2str(k) '.mat'], 'C')
    model_file = ['model/svm/' kernel_function '_' num2str(window_size) '_train.mat'];
    load (model_file, 'model') ;
    
    Detect = 0; INX = [];
    X_raw = getX_test(file_name);
    
    X = [];
    Y = [];
    
    d = ceil((window_size-1)/2);
    
    for i = 1:size(X_raw,1)
        D  = distfun(C,X_raw(i,:));	% Tinh khoang cach den cac centroid
        INX = [INX find(D == min(D))];		% Gan index 
    end
    
    for j = d+1:size(X_raw,1)-d
        X = [X; INX(j-d:j+d)];  
    end
    
    Y = predict(model, X);
    result = findseq(Y);
    output = max(result(result(:,1) == 1,4));
    if isempty(output)
        output = 0;
    end
    
    if output >= 6
        Detect = 1;
    end

end

    
