function R = rot_x(x)
    % rot_x 
    % Rotation matrix for rotation around the x axis

R = [1,        0,    0;
     0,   cos(x), -sin(x);
     0,   sin(x), cos(x);];

end

