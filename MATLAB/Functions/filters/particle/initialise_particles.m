function init_x = initialise_particles(numberOfParticles, binaryXInitialise)
% Inputs - numberOfParticles: is the number of particles generated
%        - binaryXInitialise: if 0, X is initialised at x=0, y=0, z=0. If
%        1, X is initialised randomly.
%
% Ouptuts - init_x: initial distribution of samples
%         - init_w: initial distribution of weights
%         - init_pose: initialise the robot pose

    n = numberOfParticles;
    %scale = 0.1;
    ax = -6;
    bx = 6;
    rx = ax + (bx-ax)*rand(n,1);
    ay = -4;
    by = 4;
    ry = ay + (by-ay)*rand(n,1);
    
    if (binaryXInitialise == 0)
        % initialise at (0,0,0)
        init_x = zeros(n,3);
    elseif (binaryXInitialise == 1)
        % initialise randomly
        init_x = [rx, ry, (rand(n,1))*2*pi];
    else
        disp('Input binaryXInitialise need to be binary (0 or 1)')
        return
    end
    
end