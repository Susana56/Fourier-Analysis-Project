function [sing, phi, phi_sorted]=ssa_F_ran(m,n, f)
% This functions takes desired size m,n and creates a random time series
% with m entries to replicate figures 2,3,4 in paper 
%f- filter, either low-pass or high-pass

    x= randn(m, 1);
    
% Apply filter if needed
    if f~=0    % Need to convolve the time series with kernal of given mask, want same size as the time series x
       y = conv(x,f,'same');
       x=y;
    end
    
    
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