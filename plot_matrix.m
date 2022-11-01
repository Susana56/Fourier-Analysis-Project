function plot_matrix(M)
% Take in a vector, plot the columns 
    s = size(M);
    figure
    for i=1:s(2)
        plot(1:s(1), M(:,i))
        hold on 
    end
end