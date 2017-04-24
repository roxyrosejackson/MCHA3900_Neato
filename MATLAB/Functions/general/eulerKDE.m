function T = eulerKDE(Thetanb)
%eulerKDE    Obtain transformation matrix for Euler angle kinematic differential equation
%   T = eulerKDE(Thetanb)
%   takes column vector of Euler angles and returns transformation T,
%   such that
%       dThetanb = T*omegaBNb
%
%   See also eulerRotation, eulerKinematicTransformation.

phi     = Thetanb(1);   % Roll angle
theta   = Thetanb(2);   % Pitch angle

T = [ ...
    1, sin(phi)*tan(theta), cos(phi)*tan(theta); ...
    0, cos(phi), -sin(phi); ...
    0, sin(phi)/cos(theta), cos(phi)/cos(theta) ...
    ];