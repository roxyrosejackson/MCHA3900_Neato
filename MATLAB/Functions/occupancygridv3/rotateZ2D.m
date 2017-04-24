function [xout] = rotateZ2D(x,theta)

vect = [cos(theta), -sin(theta);
    sin(theta), cos(theta)]*[x(1),x(2)]';
xout = vect;