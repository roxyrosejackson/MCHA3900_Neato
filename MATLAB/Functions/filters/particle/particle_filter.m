function output_chi_t = particle_filter(input_chi_tm1, input_velocities, input_observations)
% Inputs - input_x: particles
%        - input_w: inportance weight
%        - input_desiredPose: change in pose as a vector [x,y,phi]
%        - input_observations: avtual robot pose?
% 
% Outputs - chi_t: belief
%
% Roxy Jackson April 2017
%

    global param
    
    n = length(input_chi_tm1);
    chi_t = zeros(n,param.n_states+1,n);
    
    for j = 1:n
        % Sample motion model for x
        x = motion_model(input_velocities, input_chi_tm1, param.dt);

        % Measurement Model for w
        w = observation_measurement_model(x, input_observations);
        
        chi_t(:,:,j) = [x(:,1:3), w];
    end

    output_chi_t = low_variance_resampling(chi_t(:,:,n));
    
end