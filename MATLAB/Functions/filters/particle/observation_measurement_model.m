function weights = observation_measurement_model(input_x, input_observations)

    global param
    
    points = input_x(:,1:2);
    
    Map = EM_Mapping(input_observations, param.clusters);
    
    n = length(Map.mean);
    m = length(points);
    
    weights = zeros(m,1);
    weight_values = [Map.weights,param.extraWeight]';
    
    for i = 1:m
        for j = 1:n
           if (check_if_point_in_ellipse(points(i,:), Map.mean(:,j), Map.covariance(:,:,j)))
             break;
           elseif (j==n)
             j = j+1;
           end
        end
        weights(i) = weight_values(j);
    end
    weights = weights/sum(weights);
end