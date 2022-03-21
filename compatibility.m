function lambdas = compatibility(v1,v2,name)
% function to calculate compatibility betwwen numbers
% v1 must contain the values, while vw their uncertainty (standard deviation)
% a result less than 1 means very good, less than 2 but more than 1 good,
% less than 3 but more than 2 acceptable, more than 4 incompatible
% the third input is the name in which the results are going to be printed
% in latex format

    lambdas = [];
    file = fopen(name, "w");

    for i = 1:(size(v1,1)-1)
        for j = (i+1):size(v1,1)
            lambdas(end + 1) = abs(v1(i) - v1(j)) / sqrt(v2(i)^2 + v2(j)^2);
            fprintf(file, "\\lambda_{%i%i}: %f", j, i, lambdas(end));
        end
    end

    
    return
end