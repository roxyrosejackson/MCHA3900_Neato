function R = rot_z(x)
    % rot_z 
    % Rotation matrix for rotation around the z axis

R = [cos(x),   -sin(x),    0;
     sin(x),   cos(x),     0;
     0,        0,          1;];

end

