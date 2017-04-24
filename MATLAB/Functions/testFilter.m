clear all; clc;


global param

% Filter
param.T = 1;

num = 1;
den = [param.T, 1];
fstFilter = tf(num, den);
trdFilter = fstFilter^3;
tempfilter = ss(trdFilter);
param.filter.A = tempfilter.A;
param.filter.B = tempfilter.B;
Cgain = tempfilter.C(3);
param.filter.C = [Cgain, 0, 0;
                  0, 0, 0;
                  0, 0, 0;];

step.amp = 50;
step.freq= 0.25;

tsim = 0;


%% Run filter

sim('testFilter');


%% Get data
t = filtIn.time;
u = filtIn.signals.values;
temp = filtOut.signals.values(1,:,:); y = temp(:);
temp = filtOut.signals.values(2,:,:); dy = temp(:);
temp = filtOut.signals.values(3,:,:); ddy = temp(:);

%% Plot
figure(1);
subplot(3,1,1)
plot(t,u,t,y);
legend('Step', '0th derivative');
xlabel('Time (sec');

subplot(3,1,2)
plot(t,u,t,dy);
legend('Step', '1st derivative');
xlabel('Time (sec');

subplot(3,1,3)
plot(t,u,t,ddy);
legend('Step', '2nd derivative');
xlabel('Time (sec');

