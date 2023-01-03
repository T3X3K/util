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
    erra = sqrt(sum((x.^2)./(err.^2))/del);
    errb = sqrt(sum(1./(err.^2))/del);
    
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
   
	

	%%% RìGrafico Fit
    %me','Figure','Color',[1 1 1],'OuterPosition',[964 501 576 513]);

	% Create axes
	axes1 = axes;
	hold(axes1,'on');

	% Create errorbar
	errorbar(x,y,err,'DisplayName','Dati','LineStyle','none','LineWidth',1.2,...
	    'Color',[1 0 0]);

	% Create plot
	xr = linespace(x(1)-0.05*(x(end)-x(1)),x(end)+0.05*(x(end)-x(1)),round(x(end)-x(1))*100);
	plot(xr,a+b*xr,'DisplayName','Retta Interpolante','Color',[0 1 0]);

	hold(axes1,'off');
	% Set the remaining axes properties
	set(axes1,'XGrid','on','XMinorGrid','on','XMinorTick','on','YGrid','on',...
	    'YMinorGrid','on','YMinorTick','on');
	% Create legend
	legend(axes1,'show');

	%%% Grafico Residui 
	figure('Name','Figure','Color',[1 1 1],'OuterPosition',[672 538 576 513]);

	% Create axes
	axes1 = axes;
	hold(axes1,'on');

	% Create errorbar
	errorbar(x,s.res,err,'DisplayName','Residui','LineStyle','none',...
	    'LineWidth',1.2,...
		    'Color',[1 0 0]);

	% Uncomment the following line to preserve the X-limits of the axes
	% xlim(axes1,[0.5 6.5]);
	box(axes1,'on');
	hold(axes1,'off');
	% Set the remaining axes properties
	set(axes1,'XGrid','on','XMinorGrid','on','YGrid','on','YMinorGrid','on');
	% Create legend
	legend1 = legend(axes1,'show');
	set(legend1,...
	    'Position',[0.730952382868244 0.850793651928977 0.164285712103759 0.0476190464837211]);

	return
end
