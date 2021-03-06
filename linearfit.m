function [a, b, erra, errb] = linearfit(x, y, err)
%function to estimate the parameters for the 
%linear fit y=a+bx using the least squares method
%x and y are the vectors with data on the respective 
%axis, while err is a vector containing the uncertainties
%of the respective y values
    n = size(x, 1);
    del = sum(1./(err.^2))*sum((x./err).^2)-sum(x./(err.^2))^2;
    a = (sum(y./(err.^2))*transpose(x./err)*(x./err) - sum(x./(err.^2))*sum(x.*y./(err.^2)))/del;
    b = (sum(1./(err.^2))*sum(x.*y./(err.^2)) - sum(x./(err.^2))*sum(y./(err.^2)))/del;
    erra = sum((x.^2)./(err.^2))/del;
    errb = sum(1./(err.^2))/del;
    return
end
