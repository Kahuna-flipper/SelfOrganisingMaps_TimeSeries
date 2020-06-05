%% Creates a hexagonal mesh and initialises weights


function hexmap = CreateHexagonalSOM(rows,columns,dimensions)
elements = rows*columns;
hexmap = abs(randn(elements,dimensions));
end
