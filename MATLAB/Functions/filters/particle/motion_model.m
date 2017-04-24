function x_t = motion_model(u,x_tm1,dt)
    
    global param;
    parameters;
    
    n1 = size(x_tm1,1);
    n2 = size(x_tm1,2);
    
    % u(1)  : left motor velocity
    % u(2)  : right motor velocity
   
    vCBc        = [mean(u(1:2)), 0, 0]';
    omegaCBc    = [0, 0, (u(2) - u(1))/(2*param.wb)]';
    
    vCBc_error = sample(param.error.translation.translation*abs(vCBc(1)) + param.error.translation.angular*abs(omegaCBc(3)));
    omegaCBc_error = sample(param.error.angular.translation*abs(vCBc(1)) + param.error.angular.translation*abs(omegaCBc(3)));
    gamma_error = sample(param.error.other.one*abs(vCBc(1)) + param.error.other.two*abs(omegaCBc(3)));
    
    vCBc(1) = vCBc(1) + vCBc_error;
    omegaCBc(3) = omegaCBc(3) + omegaCBc_error;
    
    nuc = [vCBc;omegaCBc];
    
    nub3  = param.Rbc*nuc(param.IdxofI);  % u, v, r            
    
    % change in pose
    dx_t = [nub3(1)/nub3(3)*(sin(x_tm1(:,3))+sin(x_tm1(:,3)+nub3(3)*dt)), ...   % x
            nub3(1)/nub3(3)*(cos(x_tm1(:,3))-cos(x_tm1(:,3)+nub3(3)*dt)), ...  % y
            repmat(nub3(3)*dt + gamma_error*dt,n1,1)];                    % theta
    
    x_t = x_tm1 + dx_t;

end