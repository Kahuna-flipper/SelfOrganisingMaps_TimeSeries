function Main(rows,columns,epochs1,iterations,iterations2)

clear;
close all;
clc;

tic         % Starts timer

TRAIN = load('MedicalImages_TRAIN'); % Only this line needs to be changed to test a different dataset. 


%% Z-Normalisation : 

[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end



%% Creating map of desired dimensions
weights = CreateRectangularSOM(rows,columns,n-1);

sigma = epochs1;


%% Training batch 1 : Vector quantization to obtain prototype vectors for clustering
for i=1:epochs1
    [net,~] = Train(norm_train,weights,1,iterations,sigma,rows,columns);
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
map2 = CreateRectangularSOM(1,6,n-1);

[centroids,~] = Train(final_weights,map2,0.4657,iterations2,1,1,6);

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
        

toc  % Ends timer and returns time of computation


end 