function outgrid = UpdateSubGrid(mapObj,x,z,b)
%% Sped up result by at least 2 x
[row,col] = size(mapObj.mapgrid);

l.occ = 1.0986;
l.free = -1.0986;
l.lo = 0;

%% Create matrices from the x and y vectors
[Xmat,Ymat] = meshgrid(mapObj.X,mapObj.Y);

%% Distance matrix of grid points from state
Rmat = sqrt((Xmat-x(1)).^2+(Ymat-x(2)).^2);

%% Angle matrix of grid points from state
Phimat = atan2(Ymat-x(2),Xmat-x(1));

%% Number of observations
Observations = length(z(:,1));

%% Create 3D matrix for the observations where each 2D z(:,:,1) matrix is one observation value for example z(1,1)
Zrmaxvect = zeros(1,1,Observations);
Zrmaxvect(:) =  ones(Observations,1)*b.rmax;
Zrmax3Dmat = repmat(Zrmaxvect,row,col);
Zrvect = zeros(1,1,Observations);
Zrvect(:) = z(:,1);
Zr3Dmat = repmat(Zrvect,row,col);
Zthetavect = zeros(1,1,Observations);
Zthetavect(:) = z(:,2);
Ztheta3Dmat = repmat(Zthetavect,row,col);

%% Copy Rmat and Phimat into a 3D matrix with third dimension length Observations
Phi3Dmat = repmat(Phimat,1,1,Observations);
R3Dmat = repmat(Rmat,1,1,Observations);

%% Calculate Angle difference and correct for valid domain
AngleDiff3Dmat = Phi3Dmat - Ztheta3Dmat;
AngleDiff3Dmat = (AngleDiff3Dmat > pi).*(AngleDiff3Dmat - 2*pi) + (AngleDiff3Dmat <= -pi).*(AngleDiff3Dmat+2*pi) + ...
    ((AngleDiff3Dmat<=pi) & (AngleDiff3Dmat >-pi)).*AngleDiff3Dmat;

%% If, elseif statements using boolean for inverse sensor model
% Distance from grid point to state is less than b.vradius then update as free for all observations
% Boolr = R3Dmat < b.vradius;
% Lt3Dmat = Boolr.*l.free;
% Else if, Distance from grid point to state is greater than the maximum observation range or outside of scan angular width keep the same
Boolo = (R3Dmat > Zr3Dmat+b.alpha | (abs(AngleDiff3Dmat) > b.beta/2));
Lt3Dmat = Boolo.*l.lo;
% Else if, Distance from grid point to state is less than the observation range and within an object thickness set as occupied
Boolocc = ~(Boolo) & ((Zr3Dmat < Zrmax3Dmat) & (abs(R3Dmat - (Zr3Dmat+b.alpha/2)) < b.alpha/2));
Lt3Dmat = Lt3Dmat + Boolocc.*l.occ;
% Else set as free
Boolfree = (~(Boolocc|Boolo));
Lt3Dmat = Lt3Dmat + Boolfree.*l.free;
%% Testing parameters

%% Update grid by adding the log-odds matrices corresponding to each observation together
outgrid = mapObj.mapgrid + sum(Lt3Dmat,3);





 

