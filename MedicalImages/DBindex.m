function index = DBindex(labels,input,centroids)

[n,~] = size(centroids); % number of clusters

indices = zeros(n,n);

for i=1:n
    for j=1:n
        if(i==j)
            continue
        end
        S1=0;
        S2=0;
        main_cluster=find(labels==i);
        comp_cluster=find(labels==j);
        [a,~] = size(main_cluster);
        [b,~] = size(comp_cluster);
        main_dist=zeros(a,1);
        comp_dist=zeros(b,1);
        for k=1:a
            S1=S1+dtw(centroids(i,:),input(main_cluster(k),:));
        end
        for k=1:b
            S2=S2+dtw(centroids(j,:),input(comp_cluster(k),:));
        end
        %S1=min(main_dist);
        %S2=min(comp_dist);
        M=dtw(centroids(i,:),centroids(j,:));
        indices(i,j)=(S1+S2)/M;
    end
end

index = sum(max(indices'))/n;

end
        
            