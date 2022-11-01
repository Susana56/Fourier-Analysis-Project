function [sing, phi, phi_sorted]=ssa_F(x, m, n)
% This functions takes a time series of size m and finds it singular values
% and sorted phi values
% Step 1: Build ~scaled ~trajectory matrix
  
    X = zeros(m, n);
    for i = 1:n
        X(1:(m+1-i),i)= x(i:m); 
    end
    
    for j = n:-1:2
        X((m-j+2):m,j) = x(1:j-1);
    end
    
% Step 2 : Compute the singular values of the above matrix
    sing = svd(X);
    
% Step 3: find fourier tranform of x, (time series)
    x_f = fft(x);
    ps_x = abs(x_f).^2;
    
%Step 4: Compue the power bins as stated in the paper
    phi = zeros(1,n);
    l = m/(2*n);
    for j=1:n
        bottom = floor((j-1)*l);
        top = floor(j*l)-1;
        sum =0;
        for i = bottom:top
            sum = sum + ps_x(i+1);
        end
        phi(j)=sqrt(sum/l);
    end

%Step 5: Sort the phi values
    phi_sorted = sort(phi,'descend');
    
end