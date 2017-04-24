function T = trans_eulerAng(vec)
    % Generates the transformation matrix for euler angles. Taken from page
    % 35 of the MCHA3900 lecture notes.


    if(length(vec)~=3)
        error('Expecting vec to be of length n');
    end
    phi = vec(1);
    theta = vec(2);
    csi = vec(3);
    
    T = [1, sin(phi)*tan(theta), cos(phi)*tan(theta);
         0, cos(csi), -sin(csi);
         0, sin(csi)/cos(theta), cos(csi)/cos(theta);];
    



end