function  Map(x,z)

global MapObj
% x= [x,y,theta]'
% z= [range,theta], range and theta are n length column vectors,
% thetas domain is -pi < theta <= pi
% range domain is range > 0
% X,Y are grid vectors

%% Define beam characteristics
b.alpha = 0.02;      %obstacle thickness
b.beta = pi/180;     %angle of a sensor beam
b.vradius = 0.2;     %radius of vacuum
b.rmax = 5;         %max range

%% Find state column and row in grid
[xrow,xcol] = findelement(MapObj.X,MapObj.Y,x);

%% Find observation angles in world coordinates
z(:,2) = z(:,2)+x(3);
temp = (z(:,2) > pi).*(z(:,2)-2*pi);
temp = temp + (z(:,2) < -pi).*(z(:,2)+2*pi);
z(:,2) = temp + ((z(:,2) <= pi) & (z(:,2)>-pi)).*z(:,2);



xdiff = MapObj.X(2)-MapObj.X(1);
ydiff = xdiff;
 
%% Find the minimum and maximum row and column of grid to update
xlims = z(:,1).*cos(z(:,2));
xmin = min(xlims);
xmax = max(xlims);
ylims = z(:,1).*sin(z(:,2));
ymin = min(ylims);
ymax = max(ylims);
xcolmin = min(xcol,xcol + range2elements(xmin,xdiff))-2;
xcolmax = max(xcol,xcol + range2elements(xmax,xdiff))+2;
yrowmin = min(xrow,xrow + range2elements(ymin,ydiff))-2;
yrowmax = max(xrow,xrow + range2elements(ymax,ydiff))+2;


if (yrowmin < 1)
    yrowmin = 1;
end
if (xcolmin < 1)
    xcolmin = 1;
end
if (xcolmax > MapObj.n)
    xcolmax = MapObj.n;
end
if (yrowmax > MapObj.n)
    yrowmax = MapObj.n;
end

%% Calculate zmax
%z(:,3) = z(:,1) + xdiff; 


reducedMapObj.X = MapObj.X(xcolmin:xcolmax);
reducedMapObj.Y = MapObj.Y(yrowmin:yrowmax);
reducedMapObj.mapgrid = MapObj.mapgrid(yrowmin:yrowmax,xcolmin:xcolmax,2);


%% Update Grid logs
MapObj.mapgrid(yrowmin:yrowmax,xcolmin:xcolmax,2) = UpdateSubGrid(reducedMapObj,x,z,b);

    
 
