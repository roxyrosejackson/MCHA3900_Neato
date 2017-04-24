function setNeatoSteps(s, distL, distR)

    disTrav = max(abs([distL, distR]));
    vel = 0.1;      % m/s
    acc = 0.01;     % m/s^2
    
    % Initialize persistent data
    persistent pData;
    if(isempty(pData))
        pData.oldT = tic;
        pData.dorun = 1;
        pData.estTime = [];
        pData.diffT = [];
    end
    
    pData.diffT = toc(pData.oldT);
    
    if(~isempty(pData.estTime) && (pData.estTime)<pData.diffT)
        pData.dorun = 1;
    end
    
    if(pData.dorun)
        pause(0.2)
        cmdStr = sprintf('SetMotor %.1f %.1f %.1f %.1f', distL*1000, distR*1000, vel*1000, acc*1000);
        serialPrint(s, cmdStr);
        
        pData.oldT = tic;
        pData.estTime = 1.2*disTrav/vel;
        pData.dorun = 0;
        pause(pData.estTime*0.5);
    else
       warning('Command entered too soon. Previous command in operation');
       pause(pData.estTime - pData.diffT);
       disp(pData)
    end
    
end