TRAIN = load('MedicalImages_TRAIN'); % Only these two lines need to be changed to test a different dataset. %
TEST = load('MedicalImages_TEST' ); % Only these two lines need to be changed to test a different dataset. %

%% Z-Normalisation : 

[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end

tic

weights = CreateRectangularSOM(8,12,n-1);

[net,epoch_alpha] = Train(norm_train,weights,1,500,3,8,12);
[net2,epoch_alpha2] = Train(norm_train,net,1,1000,2,8,12);
[net3,epoch_alpha3] = Train(norm_train,net2,1,1500,1,8,12);

umatrix = Umatrix(net3,8,12);

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









