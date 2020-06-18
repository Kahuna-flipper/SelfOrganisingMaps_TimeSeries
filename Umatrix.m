function plot = Umatrix(weights,rows,columns)


mesh = zeros(rows,columns);


for i=1:rows
    for j=1:columns
        avg_distance=0;
        count=0;
        if(i-1>0)
            temp_index = [(i-1)*columns+j, (i-2)*colums+j];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(j+1<columns)
            temp_index = [(i-1)*columns+j, (i-1)*colums+j+1];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(i+1<rows)
            temp_index = [(i-1)*columns+j, (i)*colums+j];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(j-1>0)
            temp_index = [(i-1)*columns+j, (i-2)*colums+j-1];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(i-1>0 && j-1>0)
            temp_index = [(i-1)*columns+j, (i-2)*colums+j-1];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(i-1>0 && j+1<columns)
            temp_index = [(i-1)*columns+j, (i-2)*colums+j+1];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(i+1<rows && j+1<columns)
            temp_index = [(i-1)*columns+j, (i)*colums+j+1];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        if(i+1<rows && j-1>0)
            temp_index = [(i-1)*columns+j, (i)*colums+j-1];
            avg_distance = avg_distance+dtw(weights(temp_index(1),:),weights(temp_index(2),:));
            count = count+1;
        end
        mesh(i,j) = avg_distance/count;
    end
end


        
        
        
        