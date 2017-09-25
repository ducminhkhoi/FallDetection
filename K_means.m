function [MSE] = K_means(X, k)
    if exist(['model/kmeans/Centroid_' num2str(k) '.mat'], 'file') == 2
        load (['model/kmeans/Centroid_' num2str(k) '.mat'], 'MSE')      
    else
        temp = Inf;
        for index4 = 1:10
            seedrand = index4;
            k
            seedrand 
            rand('state',seedrand);
            randn('state',seedrand);

            [~,C,sumd] = kmeans(X,k,'emptyaction','drop','replicates',1,'MaxIter',1000);	

            mean(sumd)
            if(mean(sumd)<temp)
                temp = mean(sumd);
                MSE = temp;
                save (['model/kmeans/Centroid_' num2str(k) '.mat'], 'C', 'MSE');
            end
        end
        MSE
    end
end
