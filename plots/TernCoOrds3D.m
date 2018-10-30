%%  The Quaternary Coordinate function

function [x, y, z] = TernCoOrds3D(fA, fB, fD)
%  This function will be used inside the quatplot3 function and will be
%  used to calculate the 3D coordinates of the fractions of the various
%  components.

%  Declare
theta = deg2rad(30);

%  Adjustments
t = 0.5*tan(theta);  %  The opposite side
S = sqrt(t.^2 + 0.5^2);  %  The slanting side
vS = fD .* S;  %  Shift slanted - Is a fraction of the composition of comoponent D
vt = vS * sin(theta);  %  Shift opposite side
va = vS * cos(theta);  %  Shift adjacent side
IncY = vt;  %  The adjustment made in the Y direction
IncX = va;  %  The adjustment made in the X direction

%  Coordinates
y = fA .* sin(deg2rad(60));
x = fB + y .* cot(deg2rad(60));
y = y + IncY;
x = x + IncX;
z = fD .* (sin(deg2rad(60)))^2;