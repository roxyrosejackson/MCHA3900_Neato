%% M-step:
% For each map element <x,y> the non-normalised likelihood that
% the worlds property at <x,y> 
function [output_weight, output_mean, output_covariance, output_likelihood] = M_Step(input_data, k, expectation)
    [n,d] = size(input_data);
    output_weight = zeros(1,k);
    output_mean = zeros(d,k);
    output_covariance = zeros(d,d,k);
    
    for i = 1:k
       for ii = 1:n
           output_weight(i) = output_weight(i) + expectation(ii,i);
           output_mean(:,i) = output_mean(:,i) + expectation(ii,i)*input_data(ii,:)';
       end
       output_mean(:,i) = output_mean(:,i)/output_weight(i);
    end
    for i = 1:k
       for ii = 1:n
          output_covariance(:,:,i) = output_covariance(:,:,i) + expectation(ii,i)*(input_data(ii,:)'-output_mean(:,i))*(input_data(ii,:)'-output_mean(:,i))'; 
       end
       output_covariance(:,:,i) = output_covariance(:,:,i)/output_weight(i);
    end
    output_weight = output_weight/n;
    output_likelihood = Likelihood(input_data, k, output_weight, output_mean, output_covariance);
end