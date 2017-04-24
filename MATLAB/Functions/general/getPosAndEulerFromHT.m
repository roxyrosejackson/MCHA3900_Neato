function [eulerAng, Rab, rab] = getPosAndEulerFromHT(Aab)
    % Gets position and euler angles from a Homogeneous Transformation
    Rab = Aab(1:3, 1:3);
    rab = Aab(1:3,4);
    
    radius = @(x,y)(sqrt(x^2 + y^2));
    
    phi     = atan2(Rab(2,1), Rab(1, 1));
    theta   = atan2(-Rab(3,1), radius(Rab(3,2), Rab(3,3)));
    csi     = atan2(Rab(3,2), Rab(3,3));
    
    eulerAng = [phi, theta, csi]';
end

