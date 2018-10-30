%store the input into the variable data

data = readtable('point_120_nuni_0.1_10000.txt');
data = data(:,1:3);
nu_e = table2array(data(:,1));
nu_mu = table2array(data(:,2));
nu_tau = table2array(data(:,3));

A = nu_e(:);
B = nu_mu(:);
C = nu_tau(:);
D = 1 - (A + B + C);
%D = abs(D);
quatplot3(A, B, C,D,0.3,0.4);
%quatplot3(nu_e, nu_mu, nu_tau);
quat3label('nuE','nuMu','nuTau','Sterile');