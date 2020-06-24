TRAIN = load('MedicalImages_TRAIN'); % Only these two lines need to be changed to test a different dataset. %
TEST = load('MedicalImages_TEST' ); % Only these two lines need to be changed to test a different dataset. %

%% Z-Normalisation : 

[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end

tic

rows = 10 ;
columns = 10;

weights = CreateRectangularSOM(rows,columns,n-1);

%[net,epoch_alpha] = Train(norm_train,weights,1,200,5,rows,columns);
[net2,epoch_alpha2] = Train(norm_train,weights,0.4657,80,3,rows,columns);
[net3,epoch_alpha3] = Train(norm_train,net2,0.4657,160,2,rows,columns);
[net4,epoch_alpha4] = Train(norm_train,net3,0.4657,240,1,rows,columns);
%[net5,epoch_alpha5] = Train(norm_train,net4,0.4657,500,0,rows,columns);
umatrix = Umatrix(net4,rows,columns);
final_weights = net4;
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



hits = zeros(rows,columns);
distance = zeros(rows*columns,1);


for i=1:m
    for j=1:rows*columns
        distance(j)=dtw(norm_train(i,:),net4(j,:));
    end
    [~,index] = min(distance);
    temp_row = ceil(index/columns);
    temp_column = index-columns*(temp_row-1);
      
    hits(temp_row,temp_column) = hits(temp_row,temp_column) + 1;
end

figure(5);
heatmap(hits);



toc









