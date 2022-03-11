function [media,errore]=media(v,var)
%function to calculate weghted average.
%the formula for this average is derived
%from the least square methods
%v is a vector that contains the values
%var is a vector that contains the 
%variances of the respective entries in v
    num = 0;
    den = 0;
    for i = 1:size(v,1)
        num = num + v(i,1)/var(i,1);
        den = den + 1/var(i,1); 
    end
    media = num/den;
    errore = sqrt(1/den);

    return
end