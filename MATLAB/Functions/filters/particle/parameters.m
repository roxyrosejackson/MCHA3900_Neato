global param;

% Degrees of Interest
param.IdxofI = [1,2,6];
param.Rbc = diag([1,-1,-1]);
param.model.Qt = 0.01*eye(3);

% Inertia
param.m         = 3.90089;  % kg
param.Izz       = 0.240;    % kg*m^2

param.wb = 0.235; % Wheel base (m)

% shell dimensions (measured with a ruler)
param.lxtotal       = 0.31;     % m
param.lCOM2edge_xf  = 0.147;    % m

param.lytotal       = 0.32;     % m
param.lCOM2edge_y   = 0.16;     % m

% Sensor position
param.rsb = [-0.1,0,0]'; % m - sensor location in terms of body fixed coordinates system

% Sensor Error values [These are guessed and need to be tuned]
param.error.translation.translation = 0.01;
param.error.translation.angular = 0.025;
param.error.angular.translation = 0.02;
param.error.angluar.angular = 0.05;
param.error.other.one = 0.001;
param.error.other.two = 0.001;

% Measurement Likelihood function
param.clusters = 5;

% Particle Filter values
param.extraWeight = 0.01;
param.confidenceInterval = 0.95;
param.degreesOfFreedom = 2;
param.numberOfParticles = 200;

% System update speed
param.dt = 1;

% Mapping
param.n_points  = 4;
param.n_states  = 3;
param.n_size    = param.n_states + 2*param.n_points;
param.Fx = [eye(param.n_states), zeros(param.n_states)];


        
% Extended Kalman Filter
param.EKF.Qxt = eye(2);
param.EKF.Rxt = ones(param.n_states);


% valid range
param.range.min = param.wb/2;
param.range.max = 3;

param.degPerRot = 360;