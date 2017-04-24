function u = get_input_velocity()
    
    ar = -0.1;
    br = 0.1;
    al = -0.05;
    bl = 0.05;
    
    u(1) = ar + (br-ar)*rand(1);
    u(2) = al + (bl-al)*rand(1);

end