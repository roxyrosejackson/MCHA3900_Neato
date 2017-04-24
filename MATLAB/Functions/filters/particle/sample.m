function randNormal = sample(b)
    
    numberOfSamples = 12;
    a1 = -1;
    a2 = 1;
    randNormal = b/2*sum(a1 + (a2-a1)*rand(numberOfSamples,1));

end