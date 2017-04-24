%% Initialise the map structure if not an input
% Initialises the means, covariance, weighting and likelihood for k
% clusters
function [output_weight, output_mean, output_covariance, output_likelihood] = Initialise_Map(input_data, k)
    [n,d] = size(input_data);

    % How to use kmeans (hard clustering)
    % Inputs: 
    % input_data = n-by-d matrix
    % k = number of clusters 
    % Outputs:
    % IDX = n-by-1 vector constaining cluster indicies of each point
    % C = k-by-d matrix contains K cluster centroid locations
    [IDX, C] = kmeans(input_data, k, 'Display', 'off');
    
    output_covariance = zeros(d,d,k);
    output_weight = zeros(1,k);
    
    % Use kmeans output to initialise map values
    output_mean = C'; 
    points_in_cluster = zeros(1,k);
    for i = 1:k
       points_in_cluster(i) =  sum(IDX == i);
       output_weight(i) = points_in_cluster(i)/n;
       mod_k = repmat(IDX==i,1,d);
       cluster_data = input_data.*mod_k;
       cluster_data_temp = cluster_data(cluster_data(:,1)~=0|cluster_data(:,2)~=0,:);
       data_in_cluster = reshape(cluster_data_temp,[],d); % there may be a dimension problem here
       output_covariance(:,:,i) = cov(data_in_cluster);
    end
    
    %likelihood = Likelihood(input_data, k, weight, mean, covariance);
    output_likelihood = 0;
end