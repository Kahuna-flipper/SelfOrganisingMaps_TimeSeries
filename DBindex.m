function index = DBindex(labels,input,centroids)

n = size(centroids) % number of clusters
S1 = 0;
S2 = 0;
M = 0;
indices = zeros(n,n);

for i=1:n
    for j=1:n
        main_cluster=find(labels==i);
        comp_cluster=find(labels==j);
        for k=1:size(main_cluster)
            S1 = S1+dtw(centroids(i,:),input(main_cluster(k),:));
        end
        for k=1:size(comp_cluster)
            S2 = S2+dtw(centroids(j,:),input(comp_cluster(k),:));
        end
        M=dtw(centroids(i,:),centroids(j,:));
        indices(i,j)=(S1+S2)/M;
    end
end

index = sum(max(indices'))/n;

end
        
            