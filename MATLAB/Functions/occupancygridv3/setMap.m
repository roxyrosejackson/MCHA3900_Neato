function x = setMap(NED, sensData)
    
    x(2) = NED(1);   % y = N
    x(1) = NED(2);  % x = E
    x(3) = changeAngleToMap(NED(3)) ;
    
    z = sensData;
    %z(:,2) = changeAngleToMap(z(:,2));
    
    Map(x,z);
    
end