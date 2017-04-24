function x = removeErrNums(x)


    idx = x==0;
    x(idx) = NaN;


end