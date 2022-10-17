function [a, b, erra, errb, s] = linearfit(x, y, err)
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
    
    s.res = y - a - b*x;
    s.chi = chi2gof(s.res);
    
    s.gdl = size(x,1) - 2;
    
    s.r = corrcoef(x,y);
    s.t = s.r(1,2)*sqrt(s.gdl/(1-(s.r(1,2)^2)));
    
    s.sigma_post = sqrt(sum((y-(a+(b.*x))).^2)/s.gdl);
    
    s.delta=size(x,1)*sum(x.^2)-(sum(x)^2);
    s.a_ric = (sum(x.^2)*sum(y) - sum(x)*sum(x.*y))/s.delta;
    s.erra_ric = s.sigma_post*sqrt(sum(x.^2)/s.delta);
    s.b_ric = (size(x,1)*sum(x.*y)-sum(x)*sum(y))/s.delta;
    s.errb_ric = s.sigma_post*sqrt(size(x,1)/s.delta);
    
    return
end
