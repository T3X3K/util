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
    s.chi = chi2gof(res);
    
    s.gdl = size(x,1) - 2;
    
    s.r = corrcoef(x,y);
    s.t = r_lib(1,2)*sqrt(gdl_lib/(1-(r_lib(1,2)^2)));
    
    s.sigma_post = sqrt(sum((y-(a_lib+(lambda2.*x))).^2)/gdl_lib);
    
    s.delta=size(x,1)*sum(x.^2)-(sum(x)^2);
    s.a_ric = (sum(x.^2)*sum(y) - sum(x)*sum(x.*y))/delta;
    s.erra_ric = sigma_post_lib*sqrt(sum(x.^2)/delta);
    s.b_ric = (size(x,1)*sum(x.*y)-sum(x)*sum(y))/delta;
    s.errb_ric = s.sigma_post*sqrt(size(x,1)/delta);
    
    return
end
