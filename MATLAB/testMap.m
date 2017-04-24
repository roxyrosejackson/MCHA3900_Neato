clear all
%close all
clc



%% Initialize serial
% s = initializeSerial('COM16', 115200);
% initializeNeato(s);
% initializeNeatoLDS(s);
%% Test Map

%Run mapping simulation

global MapObj


% Initialise map
% Initialising bottom level (2) to have 0.5 probability
% Initialising top level to be boolean (1 or 0)
% if (isempty(mapgrid))
%     mapgrid = ones(n,n,2);
%     mapgrid(:,:,2) = mapgrid(:,:,2).*0;
%     
% end

n= 500;
lim = 5;

%% Form X, Y vectors
MapObj.n =500;
MapObj.lim = 5;
MapObj.mapgrid = ones(MapObj.n, MapObj.n,2);
MapObj.mapgrid(:,:,2) = MapObj.mapgrid(:,:,2).*0;

MapObj.X = linspace(-MapObj.lim,MapObj.lim,MapObj.n);
MapObj.Y = linspace(-MapObj.lim,MapObj.lim,MapObj.n);


fps = 20;

sensorRadius = 5;
npoints = 20;
barrier.x = ones(npoints,1);
barrier.y = linspace(-1,1,npoints)';
theta = atan2(barrier.y,barrier.x);
range = sqrt(barrier.y.^2 + barrier.x.^2);
NED = [0;0;0];
while (1)
    % Get sensor data
    %[theta, range] = getNeatoLDS(s); % rad, m
    NED(3) = NED(3) + 0.01;
    [theta, range] = getValidData(theta, range);
    z = [range, theta];
    if (length(z(:,1))>=1)
        tic
        mapcor = setMap(NED, z);
        mapping = toc
    end

    [N,E,~] = getMapObstcales();
    

    %tic
    figure(1);clf
    hold on
    scatter(E, N)
    plotVac(mapcor(1),mapcor(2),mapcor(3))
    xlabel('E (m)');
    ylabel('N (m)');
    hold off
    xlim([-lim lim])
    ylim([-lim, lim])
    daspect([1,1,1]);
    %ploting = toc
    pause(1/fps)  
end
      




shutdownNeato(s)