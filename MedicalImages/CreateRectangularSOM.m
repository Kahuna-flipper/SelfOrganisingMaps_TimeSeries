
%% Creates a rectangular mesh and initialises weights

function map = CreateRectangularSOM(rows,columns,dimensions)
elements = rows*columns;
map = (randn(elements,dimensions));
end




