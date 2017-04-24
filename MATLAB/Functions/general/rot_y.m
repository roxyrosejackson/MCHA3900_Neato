function R = rot_y(x)
    % rot_y 
    % Rotation matrix for rotation around the y axis

R = [cos(x),    0,      sin(x);
     0,         1,      0;
     -sin(x),   0,      cos(x);];

end

