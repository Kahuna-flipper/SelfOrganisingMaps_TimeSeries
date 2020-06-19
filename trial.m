TRAIN = load('synthetic_control_TRAIN'); % Only these two lines need to be changed to test a different dataset. %
TEST = load('synthetic_control_TEST' ); % Only these two lines need to be changed to test a different dataset. %

%% Z-Normalisation : 
[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end

tic

weights = CreateRectangularSOM(9,9,n-1);

[net,epoch_alpha] = Train(norm_train,weights,1,500,3,9,9);
[net2,epoch_alpha2] = Train(norm_train,net,1,50,2,9,9);
[net3,epoch_alpha3] = Train(norm_train,net2,1,1500,1,9,9);

umatrix = Umatrix(net3,9,9);

figure();
heatmap(umatrix,'Colormap',gray)
x = 1:9;
y = 1:9;
[X,Y] = meshgrid(x,y)
toc









