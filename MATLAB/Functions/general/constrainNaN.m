function x = constrainNaN (x, a, b)
    x(x>b) = NaN;
    x(x<a) = NaN;

end