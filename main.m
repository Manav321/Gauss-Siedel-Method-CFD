%clear all;

% order of matrix nxn
n = 20; 

% Defining matrix 
mat_A = zeros(n, n);
mat_B = zeros(n ,1);
mat_X = zeros(n, 1);

R_rms = 1;
R = zeros(1, n);
w = 1; % relaxation factor
thresshold = 1e-6;
E = []; % array to store R_rms to plot

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


while R_rms > thresshold

    R_rms = 0.0;
    
    for i = 1:n
   
        if i == 1
            R(i) = mat_B(i) - (2*mat_X(i) - mat_X(i+1));
        elseif i == n
            R(i) = mat_B(i) - (-mat_X(i-1) + 2*mat_X(i));
        else
            R(i) = mat_B(i) - (-mat_X(i-1) + 2*mat_X(i) - mat_X(i+1));
        end

        mat_X(i) = mat_X(i) + (w*R(i))/2;
        R_rms = R_rms + R(i)^2;
        
    end
    
    R_rms = sqrt(R_rms/n);
    E = [E, R_rms];

    plot(E, '-r*');
    drawnow;
end