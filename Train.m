%% Training SOM :

% Sequential learning :

function net = Train(input,weights,alpha,iteration,sigma)
[m,n] = size(input); % m is the number of inputs and n is the input dimension
[p,q] = size(weights); % p is the number of weights and q is the dimension, for sanity check q = n
for i=1:p
    sample = randi(m,1)
    sampled_vector = input(sample,:);
    
