function [media,errore]=media(v,err)
%function to calculate weghted average.
%the formula for this average is derived
%from the least square methods
%v is a vector that contains the values
%err is a vector that contains the 
%uncertainty of the respective entries in v

    num = sum(v./err.^2);
    den = sum(1./err.^2);
    media = num/den;
    errore = sqrt(1/den);

    return
end
