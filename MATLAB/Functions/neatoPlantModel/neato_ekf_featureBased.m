function [mu, cov] = neato_ekf(mu_tm1, cov_tm1, u_t, z_t)
    % neato_ekf(mu_tm1, cov_tm1, u_t, z_t)
    % 
    % f             - Parameters for filter (R_t, Q_t, n)
    % mu_tm1        - previous estimate
    % cov_tm1       - previous covariance
    % u_t           - current input
    % z_t           - current sensor readings
    %
    %   EKF SLAM: Filter Cycle
    % 1. State prediction
    % 2. Measurement prediction
    % 3. Measurement
    % 4. Data association
    % 5. Update
    global param;
    parameters;
    % Predictor
    [g,Gt]              = neato_g(u_t, mu_tm1, param.dt);
    predicted.mu        = g;
    predicted.cov_t     = Gt*cov_tm1*Gt' + param.Fx'*param.EKF.Rxt*param.Fx;


    % Corrector
    n_sensData          = length(z_t);
    
    for i = 1:n_sensData
        % index of observed feature
        [err, j] = findMinErr(predicted.mu(param.n_states : end), z_t(i,:));
        % Check correlation
        if(err>0.1)
            % No correlation to observed data, so add
            fprintf('New point added to index %d\n',j);
            % Convert sensor data to centre of mass data
            sens.theta = z_t(:,2);
            sens.range = z_t(:,1);
            com = cos2com(sens);
            predicted.mu(param.n_states+j:param.n_states+j+1) = [x(1), x(2)] + pol2cart(com.theta, com.range);
        end
        % calculate the difference between predicted feature and measure
        % feature
        delta = predicted.mu(param.n_states+j:param.n_states+j+1) - [x(1), x(2)];
        delta = delta';
        dx = delta(1);
        dy = delta(2);
        q = delta'*delta;
        % predicted feature measurement
        zpredictionit = [sqrt(q)
                       atan2(dy, dx) - predicted.mu(3)];
        % Jacobian for the observation
        lowHit = (1/q)*[  -sqrt(q)*dx,    -sqrt(q)*dy, 	0,  sqrt(q)*dx,     sqrt(q)*dy;
                        dy,             -dx,            -q, -dy,            dx;];
                    
        % Map jacobian to high dimensional space
        Hit = lowHit*Fxj(j);
        
        % Calculate Kalman gain
        Kit = predicted.cov_t*Hit'*inv(Hit*predicted.cov_t*Hit' + param.EKF.Qxt);
        
        % Update predictions
        predicted.mu = predicted.mu + Kit*(z_t(:,i)' - zpredictionit);
        predicted.cov_t = (eye(size(K_t)) - K_t*H_t)*predicted.cov_t;
        
    end
    
    mu                  = predicted.mu;
    cov                 = predicted.cov_t;

end



