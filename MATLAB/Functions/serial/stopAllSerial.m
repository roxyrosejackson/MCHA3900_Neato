function stopAllSerial()
    %   stopAllSerial
    %   kills all serial objects
    newobjs = instrfind;
    delete(newobjs);

end

