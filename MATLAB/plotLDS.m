clear all
close all
clc

%% Init Serial
s = initializeSerial('COM16', 115200);

%% Get Serial data
initializeNeato(s);
initializeNeatoLDS(s);
[theta, range] = getNeatoLDS(s);
%% Process Data

x = NaN;
y = NaN;
validRange = 5; % m

ldr.ax  = axes;
title (ldr.ax, 'NEATO LDR');
ylabel(ldr.ax, 'y (m)');
xlabel(ldr.ax, 'x (m)'); 
ldr.fig.h.Marker = 'square';
ldr.fig.h.LineStyle = 'none';
ldr.fig.h.DisplayName = 'Neato';
ldr.fig = createFigure(ldr.ax, x, y);
ldr.fig.h.Marker = 'square';
ldr.fig.h.LineStyle = 'none';

n = 300;

while 1
    
    [theta, range] = getNeatoLDS(s);
    [theta, range] = getValidData(theta, range);
    length(theta)
    x = range.*cos(theta);
    y = range.*sin(theta);
    
    createFigure(ldr.ax, x, y, ldr.fig);
end

