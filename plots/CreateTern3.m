%%  The Quaternary diagram create function
function [hold_state, next, cax] = CreateTern3(majors, TP)
%  This function will be used inside the quatplot3 function and will be
%  used to create the 3D coordinate set for the plot.

%  Offset for labels
xoffset = 0.04;
yoffset = 0.05;

%  Get hold state
cax = newplot;
next = lower(get(cax, 'NextPlot'));
hold_state = ishold;
grid off

%  Get X-Axis color so gridlines is same color
tc = get(cax, 'xcolor');  %  Gets the color of the x axis
ls = get(cax, 'gridlinestyle');  %  Gets the gridlinestyle

%  Get current default text properties
fAngle  = get(cax, 'DefaultTextFontAngle');
fName   = get(cax, 'DefaultTextFontName');
fSize   = get(cax, 'DefaultTextFontSize');
fWeight = get(cax, 'DefaultTextFontWeight');
fUnits  = get(cax, 'DefaultTextUnits');

%  Reset defaults to Axes' font attributes
%  So that the tick marks can use them
set(cax, 'DefaultTextFontAngle',  get(cax, 'FontAngle'), ...
    'DefaultTextFontName',   get(cax, 'FontName'), ...
    'DefaultTextFontSize',   get(cax, 'FontSize'), ...
    'DefaultTextFontWeight', get(cax, 'FontWeight'), ...
    'DefaultTextUnits','data');

%  Draw the diagram
%  Only if hold is off
if ~hold_state
    hold on
    %  Set background color
    if ~ischar(get(cax, 'color'))
        patch('Xdata', [0 1 0.5 0], 'Ydata', [0 0 sin(deg2rad(60)) 0], 'Zdata', [0 0 0 0], 'edgecolor', tc, 'facecolor', get(gca,'color'), 'handlevisibility', 'off', 'FaceAlpha', TP)
        patch('Xdata', [1 0.5 0.5], 'Ydata', [0 0.5*tan(deg2rad(30)) sin(deg2rad(60))], 'Zdata', [0 (sin(deg2rad(60)))^2 0], 'edgecolor', tc, 'facecolor', get(gca,'color'), 'handlevisibility', 'off', 'FaceAlpha', TP)
        patch('Xdata', [0 0.5 0.5], 'Ydata', [0 0.5*tan(deg2rad(30)) sin(deg2rad(60))], 'Zdata', [0 (sin(deg2rad(60)))^2 0], 'edgecolor', tc, 'facecolor', get(gca,'color'), 'handlevisibility', 'off', 'FaceAlpha', TP)
    end
    %  Plot borders
    plot3([0 1 0.5 0], [0 0 sin(deg2rad(60)) 0], [0 0 0 0], 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')  %  Bottom triangle
    plot3([1 0.5 0.5], [0 0.5*tan(deg2rad(30)) sin(deg2rad(60))], [0 (sin(deg2rad(60)))^2 0], 'color', tc, 'linewidth', 1, 'handlevisibility', 'off'), grid on  %  Triangle 4
    plot3([0 0.5 0.5], [0 0.5*tan(deg2rad(30)) sin(deg2rad(60))], [0 (sin(deg2rad(60)))^2 0], 'color', tc, 'linewidth', 1, 'handlevisibility', 'off'), grid on  %  Triangle 3
    set(gca, 'Visible', 'off')
    %  Create labels
    majorticks = linspace(0, 1, majors);
    majorticks = majorticks(1:end-1);
    ticklabels = num2str(majorticks(2:end)'*1);
    %  Plot Triangle 1 labels
    zeroF = zeros(size(majorticks));
    [lx1, ly1, lz1] = TernCoOrds3D(majorticks, zeroF, zeroF);
    text(lx1(2:end), ly1(2:end), lz1(2:end), ticklabels)
    [rx1, ry1, rz1] = TernCoOrds3D(1-majorticks, majorticks, zeroF);
    text(rx1(2:end)-xoffset, ry1(2:end), rz1(2:end), ticklabels)
    [bx1, by1, bz1] = TernCoOrds3D(zeroF, 1-majorticks, zeroF);
    text(bx1(2:end), by1(2:end), bz1(2:end), ticklabels, 'VerticalAlignment', 'top')
    %  Plot Triangle 2 labels
    [lx2, ly2, lz2] = TernCoOrds3D(zeroF, zeroF, majorticks);
    text(lx2(2:end)-xoffset, ly2(2:end), lz2(2:end), ticklabels)
    [rx2, ry2, rz2] = TernCoOrds3D(zeroF, 1-majorticks, majorticks);
    text(rx2(2:end), ry2(2:end), rz2(2:end), ticklabels)
    %  Plot Triangle 3 labels
    [tx3, ty3, tz3] = TernCoOrds3D(1-majorticks, zeroF, majorticks);
    text(tx3(2:end), ty3(2:end)-yoffset, tz3(2:end), ticklabels)
    %  Plot gridlines
    nlabels = length(majorticks)-1;
    for i = 1:nlabels
        %  Triangle 1
        plot3([lx1(i+1) rx1(nlabels-i+2)], [ly1(i+1) ry1(nlabels-i+2)], [0 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([lx1(i+1) bx1(nlabels-i+2)], [ly1(i+1) by1(nlabels-i+2)], [0 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([rx1(i+1) bx1(nlabels-i+2)], [ry1(i+1) by1(nlabels-i+2)], [0 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        %  Triangle 2
        plot3([lx2(i+1) rx2(i+1)], [ly2(i+1) ry2(i+1)], [lz2(i+1) rz2(i+1)], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([lx2(i+1) bx1(nlabels-i+2)], [ly2(i+1) by1(nlabels-i+2)], [lz2(i+1) 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([rx2(i+1) bx1(i+1)], [ry2(i+1) by1(1+1)], [rz2(i+1) 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        %  Triangle 3
        plot3([lx2(i+1) tx3(i+1)], [ly2(i+1) ty3(i+1)], [lz2(i+1) tz3(i+1)], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([lx2(i+1) lx1(i+1)], [ly2(i+1) ly1(i+1)], [lz2(i+1) 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([tx3(i+1) lx1(nlabels-i+2)], [ty3(i+1) ly1(nlabels-i+2)], [tz3(i+1) 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        %  Triangle 4
        plot3([rx2(i+1) tx3(i+1)], [ry2(i+1) ty3(i+1)], [rz2(i+1) tz3(i+1)], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([rx2(i+1) rx1(nlabels-i+2)], [ry2(i+1) ry1(nlabels-i+2)], [rz2(i+1) 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
        plot3([tx3(i+1) rx1(i+1)], [ty3(i+1) ry1(i+1)], [tz3(i+1) 0], ls, 'color', tc, 'linewidth', 1, 'handlevisibility', 'off')
    end
end

%  Reset defaults
set(cax, 'DefaultTextFontAngle', fAngle , ...
    'DefaultTextFontName',   fName , ...
    'DefaultTextFontSize',   fSize, ...
    'DefaultTextFontWeight', fWeight, ...
    'DefaultTextUnits', fUnits );