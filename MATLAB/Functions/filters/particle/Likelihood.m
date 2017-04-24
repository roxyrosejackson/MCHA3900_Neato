%% Calculates maximum likelihood using maximum log likelihood, Bays Theorem, and the PDF of the gaussian distribution
function L = Likelihood(input_data, k, input_weight, input_mean, input_covariance)
    [n,d] = size(input_data);
    data_mean = mean(input_data)';
    data_covariance = cov(input_data);
    L = 0;
    
    for i = 1:k
        inv_covariance = inv(input_covariance(:,:,i));
        L = L + input_weight(i)*(-0.5*n*log(det(2*pi*input_covariance(:,:,i)))...
            -0.5*(n-1)*(trace(inv_covariance*data_covariance)+(data_mean-input_mean(:,i))'*inv_covariance*(data_mean-input_mean(:,i))));
    end
end