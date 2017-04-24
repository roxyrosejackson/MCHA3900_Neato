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
    
    % State prediction
    [g,Gt]              = neato_g(u_t, mu_tm1, param.dt);
    predicted.mu        = g;
    predicted.cov_t     = Gt*cov_tm1*Gt' + param.Fx'*param.EKF.Rxt*param.Fx;

    % Measurement prediction
    rBNn    = [predicted.mu(1:2);0];
    thetabn = [0,0,predicted.mu(3)];
    
    [N,E,n] = getMapObstcales();
    zprediction_t = NaN(n, 2);
    
    Rbn = rot_z(predicted.mu(3));
    for i = 1:n
        rPNn = [N(i);E(i);0];
        delta = Rbn*(rPNn - rBNn);
        % move from C.O.M to the sensor
        delta = delta + param.rsb;
        dx = delta(1);
        dy = delta(2);
        q = delta'*delta;
        zprediction_t(i,:) = [sqrt(q), atan2(dy, dx) - predicted.mu(3)];
        
        % Jacobian for the observation
        lowHit = (1/q)*[  -sqrt(q)*dx,    -sqrt(q)*dy, 	0;  
                        dy,             -dx,            -q;];
                    
        % Map jacobian to high dimensional space
        
        
        % Calculate Kalman gain
        Kit = predicted.cov_t*Hit'*inv(Hit*predicted.cov_t*Hit' + param.EKF.Qxt);
    end
    
    % Measurement
    z_t;
    
    % Data association
    
    
    % Corrector
    n_sensData          = length(z_t);
    
    mu                  = predicted.mu;
    cov                 = predicted.cov_t;

end



