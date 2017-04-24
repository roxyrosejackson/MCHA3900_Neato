function [row,col] = findelement(X,Y,x)

tol = (X(2)-X(1))/2;
col = find((X<=x(1)+tol)&(X>x(1)-tol));
row = find((Y<=x(2)+tol)&(Y>x(2)-tol));