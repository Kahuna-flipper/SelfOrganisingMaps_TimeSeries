%% Training SOM :

% Sequential learning :

function net = Train(input,weights,alpha,iterations,sigma)
[m,n] = size(input); % m is the number of inputs and n is the input dimension
[p,q] = size(weights); % p is the number of weights and q is the dimension, for sanity check q = n
min = 100000; % temporary variable to store dtw of best matching units
BMU = ones(1,n); % stores current best matching unit
index = p; % stores index of best matching unit 

for i=1:iterations
    sample = randi(m,1)
    sampled_vector = input(sample,:);
    for j=1:p
        dist = dtw(sampled_vector, weight(j,:));
        if(dist<min)
            min = dist;
            BMU = weight(p,:);
            index = j;
        end
     l = mod(index,m);
     q = index - m*(l-1); % l and q store index of neuron for weight adjustment
    end
end 


       
        
    
