function s = skew(u)
    % Generates the Skew-symmetric operator
    if(length(u)~=3) 
        error('Expecting vector u of length 3');
    end
    s = [0, -u(3), u(2);
        u(3), 0, -u(1);
        -u(2), u(1), 0;];


end