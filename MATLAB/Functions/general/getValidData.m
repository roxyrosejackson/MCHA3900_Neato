function [theta, range] = getValidData(theta, range)

    indices = find(isnan(range) == 0);
    theta = theta(indices);
    range = range(indices);

end