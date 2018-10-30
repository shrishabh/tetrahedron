%store the input into the variable data

load('frac_90.mat')
nu_e = eFraction;
nu_mu = muFrac;
nu_tau = tauFrac;

A = nu_e(:,1);
B = nu_mu(:,1);
C = nu_tau(:,1);
D = 1 - (A + B + C);
%D = abs(D);
figure(1)
quatplot3(A, B, C,D,0.2,0.4);
%quatplot3(nu_e, nu_mu, nu_tau);
quat3label('nuE','nuMu','nuTau','Sterile');

%set('Flavor Ratio','Position',[4.98848 0.34 1.00011]) %%%Shifts upward by 0.1 units
A = nu_e(:,2);
B = nu_mu(:,2);
C = nu_tau(:,2);
D = 1 - (A + B + C);
%D = abs(D);
figure(2)
quatplot3(A, B, C,D,0.2,0.4);
quat3label('nuE','nuMu','nuTau','Sterile');

A = nu_e(:,3);
B = nu_mu(:,3);
C = nu_tau(:,3);
D = 1 - (A + B + C);
%D = abs(D);
figure(3)
quatplot3(A, B, C,D,0.2,0.4);
quat3label('nuE','nuMu','nuTau','Sterile');

A = nu_e(:,4);
B = nu_mu(:,4);
C = nu_tau(:,4);
D = 1 - (A + B + C);
%D = abs(D);
figure(4)
quatplot3(A, B, C,D,0.2,0.4);
quat3label('nuE','nuMu','nuTau','Sterile');