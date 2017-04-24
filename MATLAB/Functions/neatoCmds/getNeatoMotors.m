function data = getNeatoMotors(s)
    pauseT = 0.005;
    pause(3*pauseT);
    serialPrint(s,'GetMotors');
    pause(3*pauseT);
    fscanf(s); % remove header
    
    
    data.brush.RPM          = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.brush.mA           = csv2double(fscanf(s), ',', 2); pause(pauseT);
    
    data.vacuum.mA          = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.vacuum.RPM         = csv2double(fscanf(s), ',', 2); pause(pauseT);
    
    data.leftWheel.RPM      = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.leftWheel.load     = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.leftWheel.pos      = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.leftWheel.speed    = csv2double(fscanf(s), ',', 2); pause(pauseT);
    
    data.rightWheel.RPM     = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.rightWheel.load    = csv2double(fscanf(s), ',', 2); pause(pauseT);
    data.rightWheel.pos     = csv2double(fscanf(s), ',', 2); pause(pauseT); 
    data.rightWheel.speed   = csv2double(fscanf(s), ',', 2); pause(pauseT); 
    
    data.charger.mAH        = csv2double(fscanf(s), ',', 2); pause(pauseT); 
    
    data.sideBrush.mA       = csv2double(fscanf(s), ',', 2); pause(pauseT); 
end