function [Detect, output] = HMM_testing(k, parameter, file_name)
%   TESTHMM Test each frame using trained HMMs. Chose the most relevant HMM
%   by comparing 2 outputs from each HMM model.
   
    load (['model/kmeans/Centroid_' num2str(k) '.mat'], 'C')
    Detect = 0;
    R = [];
    window_size = parameter;
    
    load (['model/hmm/FallModel_state_5.mat'], 'estTR', 'estO', 'estO_new', 'loglik')
    estTR_fall = estTR;
    estO_new_fall = estO_new;
    
    load (['model/hmm/NonFallModel_state_5.mat'], 'estTR', 'estO', 'estO_new', 'loglik')
    estTR_nonfall = estTR;
    estO_new_nonfall = estO_new;
    
    X = getX_test(file_name);
    INX = [];
    for i = 1:size(X,1)
        D   = distfun(C,X(i,:));	% Tinh khoang cach den cac centroid
        INX = [INX find(D == min(D))];		% Gan index 

        if size(INX,2)>window_size 	% Lon hon 20 frame
            
            [~, LogPFall] = hmmdecode(INX(size(INX,2)-window_size:size(INX,2)),estTR_fall,estO_new_fall);
         
            [~, LogPNonFall] = hmmdecode(INX(size(INX,2)-window_size:size(INX,2)),estTR_nonfall,estO_new_nonfall);

            R1 = LogPFall > LogPNonFall; 

            R = [R R1];

        end  
    end
    
    result = findseq(R);
    output = max(result(result(:,1) == 1,4));
    
    if isempty(output)
        output = 0;
    end
    
    if output >= 50
        Detect = 1;
    end
end


