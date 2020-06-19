%% Training SOM :

% Sequential learning :

function [net,epoch_alpha] = Train(input,weights,alpha,iterations,sigma,row,column)
[m,n] = size(input); % m is the number of inputs and n is the input dimension
[p,~] = size(weights); % p is the number of weights

BMU = ones(1,n); % stores current best matching unit weight

dist = ones(100,1);
tic
for i=1:iterations
    sample = randi(m,1);
    sample_vector = input(sample,:);
    for j=1:p
        dist(j) = dtw(weights(j,:),sample_vector);
    end
     [~,index]=min(dist);   
     l = ceil(index/row);
     q = index - row*(l-1); % l and q store index of neuron for weight adjustment
     weights(index,:) = weights(index,:) + alpha*(sample_vector-weights(index,:));
    for r=1:sigma

         if(l<row && q+r<column)
             temp_index=(l-1)*column+(q+r);
             weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
         end
         if(l<row && q-r>0)
             temp_index=column*(l-1)+(q-r);
             weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
         end
         if(l+r<row && q<column)
             temp_index=column*(l+r-1)+(q);
             weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
         end
         if(l-r>0 && q<column)
             temp_index=column*(l-r-1)+(q);
             weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
         end
         if(sigma>1)
             for s=1:(sigma-1)
                 if(l-r+s>0 && l-r+s<row && q+s<column)
                    temp_index=column*(l-r+s-1)+(q+s);
                    weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
                 end 
                 if(l-r+s>0 && l-r+s<row && q-s>0)
                    temp_index=column*(l-r+s-1)+(q-s);
                    weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
                 end 
                 if(l-r-s>0 && l-r-s<row && q+s<column)
                    temp_index=column*(l-r-s-1)+(q+s);
                    weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
                 end 
                 if(l-r-s>0 && l-r-s<row && q-s>0)
                    temp_index=column*(l-r-s-1)+(q-s);
                    weights(temp_index,:) = weights(temp_index,:) + alpha*exp(-(dtw(weights(temp_index,:),weights(index,:)))/(2*r^2));
                 end 
             end
         end 
    alpha = 1/toc;     
    end

net = weights;
epoch_alpha = alpha;
end 


       
        
    
