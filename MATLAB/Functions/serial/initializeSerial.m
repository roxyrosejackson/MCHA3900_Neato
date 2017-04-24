function s = initializeSerial(com, baud)
    % initializeSerial(com, baud)
    % initializeSerial initializes serial communications for the NEATO
    % robot serial interface.
    
    % Delete all serial objects
    newobjs = instrfind;
    delete(newobjs);
    
    % initialize serial port
    s = serial(com,'BaudRate',baud,'TimeOut',1); % TODO: Modify port and rate as needed

    s.ReadAsyncMode = 'continuous';
    s.InputBufferSize = 64000;
    s.Terminator = 'LF';
    fopen(s);


end