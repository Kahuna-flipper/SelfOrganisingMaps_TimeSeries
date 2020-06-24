
%% Creates a rectangular mesh and initialises weights

function map = CreateRectangularSOM(rows,columns,dimensions)
elements = rows*columns;
map = (normrnd(0,1,[elements,dimensions]));
end




