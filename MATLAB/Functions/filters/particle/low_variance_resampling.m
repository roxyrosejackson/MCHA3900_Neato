function output_chi_t = low_variance_resampling(chi_t)

    n = length(chi_t);
    output_chi_t = zeros(n,3);
    a = 0;
    b = 1/n;
    r = a + (b-a)*rand(1);
    c = chi_t(1,4);
    counter = 1;
    
    for j = 1:n
       U = r +(j-1)/n;
       while (U > c)
          counter = counter + 1;
          c = c + chi_t(counter,4);
       end
       output_chi_t(j,1:3) = chi_t(counter,1:3);
    end

end