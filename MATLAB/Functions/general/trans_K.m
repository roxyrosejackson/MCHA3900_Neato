function J = trans_K( eta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if(length(eta)~=6)
       error('Expected eta of length 6'); 
    end
    posVec = eta(1:3);
    angVec = eta(4:6);
    zeroPad = zeros(3);
    R = rot_eulerAng(angVec);
    T = trans_eulerAng(angVec);
    
    J = [R, zeroPad;
        zeroPad, T;];

end

