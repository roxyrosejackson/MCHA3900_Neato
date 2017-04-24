function [err, j] = findMinErr(mappedPoints, zit)
    % findMinErr(mappedPoints, zit)
    % mappedPoints - All mapped points
    % zit          - Single sensor reading
    
    global param;
    parameters;
    minErr = [];
    for i = 1:2:2*param.n_points
        % Convert sensor data to centre of mass data
        sens.theta = zit(1,2);
        sens.range = zit(1,1);
        com = cos2com(sens);
        [x,y] = pol2cart(com.theta, com.range);
        
        % compare the error of all the data and the mapped point
        errCart = [x,y] - mappedPoints(i:i+1);
        err     = sqrt(errCart(1)^2 + errCart(2)^2);
        minErrIdx = find(min(err(:))==err);
        
        % Update the minimium error variable
        if(isempty(totalMinErr))
            minErr = err(minErrIdx);
        end
        if(minErr>err(minErrIdx))
            minErr = err(minErrIdx);
            j=ceil(i/2);                % change indexing to relate to map points
        end
    end

end