TRAIN = load('synthetic_control_TRAIN'); % Only these two lines need to be changed to test a different dataset. %
TEST = load('synthetic_control_TEST' ); % Only these two lines need to be changed to test a different dataset. %

%% Z-Normalisation : 
[m,n] = size(TRAIN);
norm_train = TRAIN(:,2:n);

for i=1:m
    norm_train(i,:) = (norm_train(i,:)-mean(norm_train(i,:)))/std(norm_train(i,:));
end



