clear all
close all
clc

parameters;
global param;

%% Map
global MapObj
MapObj.n =500;
MapObj.lim = 5;
MapObj.mapgrid = ones(MapObj.n, MapObj.n,2);
MapObj.mapgrid(:,:,2) = MapObj.mapgrid(:,:,2).*0;

MapObj.X = linspace(-MapObj.lim,MapObj.lim,MapObj.n);
MapObj.Y = linspace(-MapObj.lim,MapObj.lim,MapObj.n);


cov = eye(param.n_states);
mu  = zeros(param.n_states,1);
z_t  = ones(param.n_points,1);
u_t  = zeros(2,1);

npoints = 20;
barrier.x = ones(npoints,1);
barrier.y = linspace(-1,1,npoints)';
theta = atan2(barrier.y,barrier.x);
range = sqrt(barrier.y.^2 + barrier.x.^2);

steps = 100;
for i = 1:steps
    [theta, range] = getValidData(theta, range);
    z = [range, theta];
    
    mapcor = setMap(mu, z);
    [mu, cov] = neato_ekf(mu, cov, u_t, z);
    

end

