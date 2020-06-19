TRAIN = load('Wine_TRAIN'); % Only these two lines need to be changed to test a different dataset. %
TEST = load('Wine_TEST' ); % Only these two lines need to be changed to test a different dataset. %

%% Z-Normalisation : 

[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end

tic

weights = CreateRectangularSOM(6,6,n-1);

[net,epoch_alpha] = Train(norm_train,weights,1,500,3,6,6);
[net2,epoch_alpha2] = Train(norm_train,net,1,1000,2,6,6);
[net3,epoch_alpha3] = Train(norm_train,net2,1,1500,1,6,6);

umatrix = Umatrix(net3,6,6);

figure(1);
heatmap(umatrix,'Colormap',gray)
% x = 1:8;
% y = 1:11;
% [X,Y] = meshgrid(x,y)

figure(2);
surf(umatrix);
colormap(gray);

figure(3);
contour(umatrix);
colormap(gray);

figure(4);
contour3(umatrix);
colormap(cool);
toc









