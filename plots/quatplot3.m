%QUATPLOT3 plot 3dimensional phase diagram
%  QUATPLOT3(A,B,C) plots the 3D quaternary phase diagram for four
%  components.  D is calculated as 1 - A - B - C
%
%  QUATPLOT(A,B,C,D) plots the 3D quaternary diagram for the four
%  components.  If the values are not fractions, they will be normalized by
%  dividing by the total.
%
%  QUATPLOT(A,B,C,D,GS) same as above, but uses GS as the grid spacing.  A
%  default value of 0.2 will be assumed if not specified.
%
%  QUATPLOT(A,B,C,D,GS,TRANSPARANCY) same as above, but the TRANSPARANCY of
%  the faces of the plot can be varied.  1 being totally opaque and 0 being
%  totally transparent.  A default value of 0.5 will be assumed if not
%  specified.
%
%  QUATPLOT(A,B,C,D,GS,TRANSPARANCY,LINETYPE) same as above, but with a
%  user specified LINETYPE.
%
%  QUATPLOT(...,'PropertyName','PropertyValue',...) same as above, but sets
%  properties to specified values.
%
%  NOTES
%  - The regular TITLE and LEGEND commands work with the plot from this
%    function, as well as incremental plotting using HOLD.
%  - Labels can be placed on the axes using QUATLABEL.
%
%  See also QUAT3LABEL QUATPLOT QUATLABEL
%
%  Author:  Jacques van der Merwe

function hquat3 = quatplot3(varargin)

%%  Declare inputs
if nargin > 5
    A = varargin{1};
    B = varargin{2};
    C = varargin{3};
    D = varargin{4};
    GridSpace = varargin{5};
    TP = varargin{6};
end

if nargin == 3
    A = varargin{1};
    B = varargin{2};
    C = varargin{3};
end

if nargin == 4
    A = varargin{1};
    B = varargin{2};
    C = varargin{3};
    D = varargin{4};
end
%%  Test inputs
if nargin < 3
    error('Not enough input arguments')
elseif nargin < 4
    D = 1 - A - B - C;
    GridSpace = 0.2;
    TP = 0.5;
elseif nargin < 5
    GridSpace = 0.2;
    TP = 0.5;
elseif nargin < 6
    TP = 0.5;
elseif nargin > 7
    if rem(nargin,2) == 0
        error('Property inputs must be specified in pairs')
    end
end

%%  Normalize fractions
[fA,fB,fC,fD] = NormFrac(A,B,C,D);

%%  Calculate quaternary Coordinates
[x, y, z] = TernCoOrds3D(fA, fB, fD);

%%  Sort data
[x, ind] = sort(x);
y = y(ind);
z = z(ind);

%%  Create the quaternary axes
majors = 1 / GridSpace + 1;
[hold_state, next, cax] = CreateTern3(majors, TP);  %  This will create the quaternary axes

%x
%y
%z
%%  Plot data
if length(varargin)<7
    %q = plot3(x,y,z);
    q = scatter3(x,y,z);
elseif length(varargin) == 7
    q = plot3(x,y,z, varargin{7});
elseif length(varargin)>7
    q = plot3(x, y, z, varargin{7:nargin});
end

if nargout > 0
    hquat3 = q;
end

if ~hold_state
    set(gca, 'dataaspectratio', [1 1 1]), axis off
    set(cax, 'NextPlot', next)
end







% %%  The degrees to radian function
% function rad = deg2rad(deg)
% %  This function is used inside the ternplot function and will be used to
% %  convert from degrees to radians
% 
% %  Calculations
% rad = deg / 180 * pi;