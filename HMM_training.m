function [estTR, estO, estO_new, loglik] = HMM_training(k,state,Seedrand,list_videos,time)
%   HMM_TRAINING Train 2 HMM models using hmmdecode function.

    load (['model/kmeans/Centroid_' num2str(k) '.mat'], 'C')

    Seq1 = {};
    for index3 = 1:size(list_videos,1)
        video_name = list_videos(index3)
        X = getX_train(video_name, time(index3,:));

        INX = [];
        for index4 = 1:size(X,1)
            D = distfun(C,X(index4,:));	% Calculate the distance from each feature to the centroids.
            INX = [INX find(D==min(D))];		    % Add index to each frame.
        end
        
        Seq1 = [Seq1 {INX}];	% Accumulate Index.
    end
    
    rand('state',Seedrand);
    randn('state',Seedrand);
    % -------------------------------------------------------------------------
    % initial guess for transmission matrix

    guessTR = [];
    
    % 'left2right'
    for index4=1:state
        a = rand(1,state-index4+1);
        row = [zeros(1,index4-1) a./sum(a)];
        guessTR = [guessTR; row];
    end      
    
    % -------------------------------------------------------------------------
    % prior
    guessO = [];

    for index4=1:state
        b = rand(1,k);
        row = b./sum(b);
        guessO = [guessO; row];
    end

    [estTR, estO, loglik] = hmmtrain(Seq1, guessTR, guessO,'Maxiterations',100000);

    %--------------------------------------------------------------------------

    % Solution to insufficient training data
    estO_new = [];
    for index4=1:state
        row = estO(index4,:)+10^(-6);
        row_estO_new = row/(sum(row));
        estO_new = [estO_new; row_estO_new];
    end
end

