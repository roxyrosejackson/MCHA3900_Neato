function [N,E,n] = getMapObstcales()
    global MapObj;
    MapObj.mapgrid(:,:,1) = MapObj.mapgrid(:,:,2) > 0.0;
    [Orow,Ocol] = find(MapObj.mapgrid(:,:,1));
    E = MapObj.Y(Ocol);
    N = MapObj.X(Orow);
    n = length(MapObj.Y(Ocol));
    
end