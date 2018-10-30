%%  The Normalization function
function [fA,fB,fC,fD] = NormFrac(A,B,C,D)
%  This function will be used inside the quatplot3 function and will be
%  used to normalize the fractions given by the user

%  Calculations
total = A+B+C+D;
fA = A ./ total;
fB = B ./ total;
fC = C ./ total;
fD = D ./ total;