function matrix=normalizing(matrix1)
SUM=sum(sum(matrix1));
matrix=matrix1/SUM;
end