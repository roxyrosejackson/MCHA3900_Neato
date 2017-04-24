function runMapSim()
%%Run mapping simulation

global MapObj


% Initialise map
% Initialising bottom level (2) to have 0.5 probability
% Initialising top level to be boolean (1 or 0)
% if (isempty(mapgrid))
%     mapgrid = ones(n,n,2);
%     mapgrid(:,:,2) = mapgrid(:,:,2).*0;
%     
% end
spacing = 0.025;
MapObj.lim = 5;
MapObj.n= round((2*MapObj.lim+1)/spacing);


%% Form X, Y vectors
MapObj.mapgrid = ones(MapObj.n,MapObj.n,2);
MapObj.mapgrid(:,:,2) = MapObj.mapgrid(:,:,2).*0;

MapObj.Y = linspace(-MapObj.lim,MapObj.lim,MapObj.n);
MapObj.X = linspace(-MapObj.lim,MapObj.lim,MapObj.n);
%Map(mapgrid,X,Y);
Obstacles = 100;
ObstaclePoints = rand(Obstacles,2)*2*MapObj.lim-MapObj.lim;
StartState = [0,0,0];   %x,y,theta
fps = 20;
StateSteps = fps*2;

sensorRadius = 5;
z = zeros(Obstacles,2);
while (1)
    NextState = [rand(1,2)*2*MapObj.lim-MapObj.lim, rand(1)*2*pi-pi];
    Trajectory = [linspace(StartState(1),NextState(1),StateSteps)',...
            linspace(StartState(2),NextState(2),StateSteps)',...
            linspace(StartState(3),NextState(3),StateSteps)'];
    for i=1:StateSteps
        
        
        StateMat = ones(Obstacles,3);
        StateMat = [StateMat(:,1)*Trajectory(i,1),StateMat(:,2)*Trajectory(i,2),StateMat(:,3)*Trajectory(i,3)];
        ObstacleDistTemp = sqrt((StateMat(:,1)-ObstaclePoints(:,1)).^2+(StateMat(:,2)-ObstaclePoints(:,2)).^2);
        ObstacleAngle = atan2(ObstaclePoints(:,2)-StateMat(:,2),ObstaclePoints(:,1)-StateMat(:,1))-StateMat(:,3);
        temp = (ObstacleAngle<-pi).*(ObstacleAngle+2*pi);
        temp = temp + (ObstacleAngle>pi).*(ObstacleAngle-2*pi);
        ObstacleAngle = temp + (ObstacleAngle < pi & ObstacleAngle > -pi).*ObstacleAngle;
        ObstacleDist = (ObstacleDistTemp<sensorRadius).*ObstacleDistTemp;
        ObstacleAngle = (ObstacleDistTemp<sensorRadius).*ObstacleAngle;
        z=[ObstacleDist(find(ObstacleDist)),ObstacleAngle(find(ObstacleAngle))];
        x= Trajectory(i,:);
        if (~isempty(z))
            if (length(z(:,1)>=1))
                tic
                Map(x,z);
                mapping = toc
            end
        end
  
        MapObj.mapgrid(:,:,1) = MapObj.mapgrid(:,:,2) > 0;
        [Orow,Ocol] = find(MapObj.mapgrid(:,:,1));
        Ox = MapObj.X(Ocol);
        Oy = MapObj.Y(Orow);
  
        %tic
        clf
        hold on
        scatter(Ox,Oy)
        scatter(ObstaclePoints(:,1),ObstaclePoints(:,2),'gx')
        plotVac(x(1),x(2),x(3))
        hold off
        xlim([-MapObj.lim MapObj.lim])
        ylim([-MapObj.lim, MapObj.lim])
        daspect([1,1,1]);
        %ploting = toc
        pause(1/fps)  
    end
    StartState = Trajectory(end,:);
end        
