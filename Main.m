%function Main(rows,columns,epochs1,iterations,iterations2)


close all;
clc;

tic         % Starts timer

% Only this line needs to be changed to test a different dataset. 

%% Variable declaration for testing :
rows = 10;
columns = 10; 
epochs1 = 4;
iterations = 100; 
iterations2 = 100;

%% Z-Normalisation : 

[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end



%% Creating map of desired dimensions
weights = CreateRectangularSOM(norm_train,rows,columns);

sigma = epochs1;


%% Training batch 1 : Vector quantization to obtain prototype vectors for clustering
for i=1:epochs1
    [net,~] = Train(norm_train,weights,0.9,iterations,sigma,rows,columns);
    weights = net;
    sigma = sigma-1;
end


final_weights = net;

%% Generating Umatrix for visualization
umatrix = Umatrix(final_weights,rows,columns);  


%% Generating Hits
hits = zeros(rows,columns);
distance = zeros(rows*columns,1);
close_units = zeros(m,1);

for i=1:m
    for j=1:rows*columns
        distance(j)=dtw(norm_train(i,:),final_weights(j,:));
    end
    [~,index] = min(distance);
    close_units(i)=index;
    temp_row = ceil(index/columns);
    temp_column = index-columns*(temp_row-1);
      
    hits(temp_row,temp_column) = hits(temp_row,temp_column) + 1;
end

%% Final Clustering(Code to be added for quantization error)
map2 = CreateRectangularSOM(final_weights,1,6);

[centroids,~] = Train(final_weights,map2,0.9,iterations2,1,1,6);

[a,~] = size(centroids);
close_units2=zeros(rows*columns,1);
distance = zeros(a,1);
for i=1:rows*columns
    for j=1:a
        distance(j)=dtw(final_weights(i,:),centroids(j,:));
    end
    [~,index] = min(distance);
    close_units2(i)=index;
end
    
%% Plotting attributes

figure(1);
heatmap(umatrix,'Colormap',gray)

figure(2);
surf(umatrix);
colormap(gray);

figure(3);
contour(umatrix);
colormap(gray);

figure(4);
contour3(umatrix);
colormap(cool);

figure(5);
heatmap(hits);

%% Plotting clusters
for i=1:6
    figure();
    temp = find(close_units2==i);
    [k,~] = size(temp);
    for j=1:k
        temp2=find(close_units==temp(j));
        [p,~]=size(temp2);
        if(p~=0)
            
           for l=1:p
               plot(norm_train(temp2(l),:));
               hold on;
           end
        end
    end
end

clusters = zeros(m,1);

for i=1:size(close_units)
    clusters(i)=close_units2(close_units(i));
end

    

toc  % Ends timer and returns time of computation


%end 