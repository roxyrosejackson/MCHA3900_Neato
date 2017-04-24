function x = constrain (x, a, b)
    x(x>b) = b;
    x(x<a) = a;

end