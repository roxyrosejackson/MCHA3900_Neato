%% Initialise workspace 
clc
clear 
close all

parameters();

%% script to trial new functions
global param

timesToRunThrough = 19;

npoints = 300;
mu_1 = [1 2];
mu_2 = [-2 1];
mu_3 = [5 0];
Sigma_1 = chol([1 .5; .5 2]);
Sigma_2 = chol([6 2; 2 3]); 
Sigma_3 = chol([1.4 1; 1 1.4]);
z_1 = repmat(mu_1,npoints,1) + randn(npoints,2)*Sigma_1;
z_2 = repmat(mu_2,npoints,1) + randn(npoints,2)*Sigma_2;
z_3 = repmat(mu_3,npoints,1) + randn(npoints,2)*Sigma_3;
 
chi = zeros(param.numberOfParticles,param.n_states,timesToRunThrough+1);

observation_data = [z_1; z_2; z_3];

chi(:,:,1) = initialise_particles(param.numberOfParticles, 1);

for k = 1:timesToRunThrough

   input_velocity = get_input_velocity();
   
   chi(:,:,k+1) = particle_filter(chi(:,:,k), input_velocity, observation_data);
   
end

%% Plot Stuff
colourVector = hsv(timesToRunThrough+1);

figure(1)
clf;
plot(observation_data(:,1), observation_data(:,2),'k.')
pause(1);
hold on
for i = 1:timesToRunThrough+1
    plot(chi(:,1,i),chi(:,2,i),'*','Color',colourVector(i,:))
    pause(1);
end
hold off