function plotVac(xc,yc,theta)
%clf
%inputs -   xc -  x coordinate of robot centre
%           yc -  y coordinate of robot centre
%           theta - orientation of robot

circy= (-0.15:0.01:0.15)';
circx = -sqrt(0.15^2-circy.^2)-0.05;

scancentre = [-0.1,0]';
scanradius = 0.08;
sensxt = scancentre(1) + (-scanradius:0.01:scanradius)';
sensxb = scancentre(1) + (scanradius:-0.01:-scanradius)';
sensyt = sqrt(scanradius^2 - (sensxt - scancentre(1)).^2)+scancentre(2);
sensyb = -sqrt(scanradius^2 - (sensxt - scancentre(1)).^2)+scancentre(2);


VacuumXY = [ 0.15,0.15;
    0.15,-0.15;
    -0.05,-0.15;
    circx,circy;
    -0.05,0.15];

ScannerXY = [sensxt,sensyt;
    sensxb,sensyb];

 for i=1:length(VacuumXY(:,1));
     VacuumXY(i,:)=rotateZ2D(VacuumXY(i,:),theta);
     
 end
 
 for i=1:length(ScannerXY(:,1))
     ScannerXY(i,:)=rotateZ2D(ScannerXY(i,:),theta);
 end

patch(VacuumXY(:,1)+xc,VacuumXY(:,2)+yc,'g')
patch(ScannerXY(:,1)+xc,ScannerXY(:,2)+yc,'b')


