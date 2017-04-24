function R = rot_eulerAng(vec)
    % Generates the rotation matrix for euler angles. Taken from page 34 of
    % the MCHA3900 lecture notes.
    r_s = @(x)(sin(x));
    r_cc = @(x,y)(cos(x)*cos(y));
    r_cs = @(x,y)(cos(x)*sin(y));
    r_sc = @(x,y)(r_cs(y,x));
    r_ss = @(x,y)(sin(x)*sin(y));
    r_css = @(x,y,z)(cos(x)*sin(y)*sin(z));
    r_ccs = @(x,y,z)(cos(x)*cos(y)*sin(z));
    r_sss = @(x,y,z)(sin(x)*sin(y)*sin(z));
    r_scs = @(x,y,z)(sin(x)*cos(y)*sin(z));

    if(length(vec)~=3)
        error('Expecting vec to be of length n');
    end
    phi = vec(1);
    theta = vec(2);
    csi = vec(3);
    
    R = [r_cc(csi,theta), -r_sc(csi, phi) + r_css(csi,theta,phi), r_ss(csi, phi) + r_ccs(csi,phi,theta);
        r_sc(csi, theta), r_cc(csi, phi) + r_sss(phi,theta,csi), -r_cs(csi, phi) + r_scs(csi,phi,theta);
        -r_s(theta), r_cs(theta, phi), r_cc(theta, phi);];
    
    



end