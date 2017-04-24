clear all
close all
clc

s = initializeSerial('COM16', 115200);

%% Get Serial data
initializeNeato(s)

%% 
steps = 2;
dir = 0.03*[-1,1];

for i = 1:steps
    idx = mod(i,2)+1;
    setNeatoSteps(s, dir(idx),dir(idx))    
    data = getNeatoMotors(s);
    leftWheel(i) = data.leftWheel;
    rightWheel(i) = data.rightWheel;
end


shutdownNeato(s)