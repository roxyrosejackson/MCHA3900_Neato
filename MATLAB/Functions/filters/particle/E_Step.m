%% E-step: 
% 1. Forward Localisation (alpha)
% 2. Linverse Localisation (beta)
% 3. Multiplication of 1 and 2 (gamma = alpha*beta)
function Expectation = E_Step(input_data, k, input_weight, input_mean, input_covariance)
    [n,d] = size(input_data);
    eta = (2*pi)^(0.5*d);
    Sigma = zeros(1,k);
    inv_covariance = zeros(d,d,k);
    Expectation = zeros(n,k);
    
    for i = 1:k
       if input_covariance(:,:,i)==zeros(d,d)
          input_covariance(:,:,i) = ones(d,d)*eps; 
       end
       Sigma(i) = sqrt(det(input_covariance(:,:,i)));
       inv_covariance(:,:,i) = inv(input_covariance(:,:,i));
    end
    for i = 1:n
       for ii = 1:k
          P =  (exp(-0.5*(input_data(i,:)'-input_mean(:,ii))'*inv_covariance(:,:,ii)*(input_data(i,:)'-input_mean(:,ii))))/(eta*Sigma(ii));
          Expectation(i,ii) = input_weight(ii)*P;
       end
       Expectation(i,:) = Expectation(i,:)/sum(Expectation(i,:));
    end
end