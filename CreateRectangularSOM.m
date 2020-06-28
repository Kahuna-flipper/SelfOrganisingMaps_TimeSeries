
%% Creates a rectangular mesh and initialises weights

function map = CreateRectangularSOM(input_samples,rows,columns)
elements = rows*columns;
[m,n] = size(input_samples);
sample = randperm(m,elements);
map = zeros(elements,n);
for i=1:elements
    map(i,:)=input_samples(sample(i),:);
end
%map = (normrnd(0,1,[elements,dimensions]));
end




