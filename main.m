%% Code to solve system of equations by Gauss Seidel with relaxation

%{ 
the coefficient matrix is of order nxn
The coeffecient matrix should be like the following -

              a  -1   0   0  ...  0   0   0   1  
             -1   a  -1   0  ...  0   0   0   0
              0  -1   a  -1  ...  0   0   0   0
              .   .   .   .       .   .   .   .
              .   .   .   .       .   .   .   .
              .   .   .   .       .   .   .   . 
              0   0   0   0  ...  -1  a  -1   0
              0   0   0   0  ...  0  -1   a  -1
              1   0   0   0  ...  0   0   -1  a

    'a' can be defined below as diagonal element 
%}

clear all;

% order of matrix nxn
n = 20; 

% Defining matrix 
mat_A = zeros(n, n);
mat_B = zeros(n ,1);
mat_X = zeros(n, 1);

a = 2;              % diagonal element of matrix A
R_rms = 1;          % defining as 1 to initiate while loop
R = zeros(1, n); 
w = 1;              % relaxation factor
error = 1e-6;   
E = [];             % array to store R_rms to plot
count = 0;          % to count iterations

% Inputting values of matrix A
for i=1:n
    for j=1:n
        if i==1 && i==j
            mat_A(i,j) = a;
            mat_A(i, j+1) = -1;
            mat_A(i, n) = 1;
        
        elseif i==j && i>=2 && i<=n-1
            mat_A(i, j-1) = -1;
            mat_A(i, j) = a;
            mat_A(i, j+1) = -1;
        
        elseif i==j && i==n
            mat_A(i, 1) = 1;
            mat_A(i, j-1) = -1;
            mat_A(i, j) = a;
        end    
    end
end

% Inputting values in matrix B
mat_B(n,1) = 1;


while R_rms > error

    R_rms = 0.0;
    
    for i = 1:n
   
        if i == 1
            R(i) = mat_B(i) - (a*mat_X(i) - mat_X(i+1) + mat_X(n));
        elseif i == n
            R(i) = mat_B(i) - (mat_X(1) - mat_X(i-1) + a*mat_X(i));
        else
            R(i) = mat_B(i) - (-mat_X(i-1) + a*mat_X(i) - mat_X(i+1));
        end

        mat_X(i) = mat_X(i) + (w*R(i))/a;
        R_rms = R_rms + R(i)^2;
        
    end
    
    R_rms = sqrt(R_rms/n);
    E = [E, R_rms];
    count = count + 1;
    
    % you can comment the next lines for fast runtime
    plot(E, '-r*');
    grid on;
    xlabel("Iterations");
    ylabel("RMS")
    drawnow;
end