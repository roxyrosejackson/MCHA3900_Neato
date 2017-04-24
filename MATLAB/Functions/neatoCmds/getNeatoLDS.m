function [theta, range] = getNeatoLDS(s)
    % getNeatoLDS(s)
    % getNeatoLDS takes in the serial object and sends commands to run a
    % LDR scan on the NEATO vacuum. initializeNeatoLDS must be called
    % before this function is called to ensure that the LDR unit is
    % spinning.
    %
    global param;
    parameters;
    n = 360;
    theta = zeros(n,1);
    range = zeros(n,1);
    str = cell(n,1);
    fprintf(s,'GetLDSScan');
    
    % Scan and discard unwanted echo and headers
    %pause(0.1);
    fscanf(s);
    fscanf(s);
    
    % Get data from NEATO
    for i = 1:n
        str{i} = fscanf(s);
        C = strsplit(str{i},',');
        if(~isempty(C))
            theta(i) = str2double(C{1});   % Deg
            range(i) = str2double(C{2});   % mm
        end 
    end
    
    % Scan and discard unwanted data
    fscanf(s);
    
    % Convert data to SI units
    theta = deg2rad(theta); % rad
    range = range/1000;     % m
    range = constrainNaN(range, param.range.min, param.range.max);
    
end