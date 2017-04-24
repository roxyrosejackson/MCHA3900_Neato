function shutdownNeato(s)
    cmdStr = 'TestMode off';
    serialPrint(s, cmdStr);

end