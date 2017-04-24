clear all
close all
clc

x = linspace(0,2*pi);
y = sin(x);
steps = 100;
phi = linspace(0, 2*pi, steps);

sinplot.ax  = axes;
title(sinplot.ax, 'sin(x)');
ylabel(sinplot.ax, 'sin(x)');
xlabel(sinplot.ax, 'x');
sinplot.fig = createFigure(sinplot.ax, x, y);
sinplot.fig.h.Marker = 'square';
sinplot.fig.h.LineStyle = 'none';
sinplot.fig.h.DisplayName = 'Neato';

tic
for i = 1:steps
    y = sin(x + phi(i));
    sinplot.ax.Title.String = sprintf('sin(x + %.3f)', phi(i));
    createFigure(sinplot.ax, x, y, sinplot.fig);
end
t = toc;
fps = steps/t
a = sinplot.fig.h