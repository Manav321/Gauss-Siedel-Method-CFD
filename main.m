% order of matrix nxn
n = 20; 

% Defining matrix 
mat_A = zeros(n, n);
mat_B = zeros(n ,1);
mat_X = zeros(n, 1);

% Inputting values of matrix A
for i=1:n
    for j=1:n
        if i==1 && i==j
            mat_A(i,j) = 2;
            mat_A(i, j+1) = -1;
        
        elseif i==j && i>=2 && i<=n-1
            mat_A(i, j-1) = -1;
            mat_A(i, j) = 2;
            mat_A(i, j+1) = -1;
        
        elseif i==j && i==n
            mat_A(i, j-1) = -1;
            mat_A(i, j) = 2;
        end    
    end
end

% Inputting values in matrix B
mat_B(n,1) = 1;