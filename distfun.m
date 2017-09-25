function D = distfun(X, C)
%   DISTFUN Calculate point to cluster centroid distances.
%   Written date : 12/02/2012
%   Test date    : 19/02/2012 
%   AUTHOR       : LAI THI KIM PHUNG

    [n,p] = size(X);
    D = zeros(n,size(C,1));
    nclusts = size(C,1);

    for index1 = 1:nclusts % Consider all Centroid. Calculate each point with 1 Centroid.
        D(:,index1) = (X(:,1) - C(index1,1)).^2;
        for index2  = 2:p
            D(:,index1) = D(:,index1) + (X(:,index2) - C(index1,index2)).^2;
        end
% D(:,i) = sum((X - C(repmat(i,n,1),:)).^2, 2);
    end
end