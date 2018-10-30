%%  The degrees to radian function
function rad = deg2rad(deg)
%  This function is used inside the ternplot function and will be used to
%  convert from degrees to radians

%  Calculations
rad = deg / 180 * pi;