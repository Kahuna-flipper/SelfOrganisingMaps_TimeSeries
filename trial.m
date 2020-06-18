TRAIN = load('synthetic_control_TRAIN'); % Only these two lines need to be changed to test a different dataset. %
TEST = load('synthetic_control_TEST' ); % Only these two lines need to be changed to test a different dataset. %

%% Z-Normalisation : 
[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end

tic
weights = CreateRectangularSOM(10,10,n-1);

[net,epoch_alpha] = Train(norm_train,weights,1,1000,3,10,10);
toc









