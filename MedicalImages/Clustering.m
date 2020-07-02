function [errors,close_units2] = Clustering(weights,iterations,rows,columns)

errors=zeros(iterations-1,1);

for num=2:iterations
    map2 = CreateRandomRectangularSOM(weights,1,num);
    [centroids,~] = Train(weights,map2,0.9,700,1,1,num);
    [a,~] = size(centroids);
    close_units2=zeros(rows*columns,1);
    distance = zeros(a,1);
    for i=1:rows*columns
        for j=1:a
            distance(j)=dtw(weights(i,:),centroids(j,:));
        end
        [~,index] = min(distance);
        close_units2(i)=index;
    end
    errors(num-1)=DBindex(close_units2,weights,centroids);
end

end