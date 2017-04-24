%% Expectation maximisation algorithm to determine likelihood of laser measurements
function Map = EM_Mapping(input_data, num_gaussians, Init_Map, likelihood_tolerance, max_iterations)
% Inputs: 
% [Matrix] input_data(n,d)  - n = number of observations
%                           - d = dimension of variable
% [Variable] num_gaussians  - Number of gaussians in data (k)
% [Structure of initial weights mean covariance] Init_Map       - Init_Map.weights = initial weights
%                                                               - Init_Map.mean = initial mean vectors
%                                                               - Init_Map.covariance = initial covariance
%                                                                 matrix
% [Variable] likellihood_tolerance - percentage of likelihood difference
% between two iterations 
% [Variable] max_iterations - maximum number of iterations until
% convergence
%
% Outputs:
% [Structure of final weights mean covariance likelihood] Map   - Map.weights(1,k) = Estimated Weights 
%                                                               - Map.mean(d,k) = Estimated mean vectors
%                                                               - Map.covariance(d,d,k) = Estimated covariance
%                                                                 matrices 
%                                                               - Map.likelihood = Log likelihood of Estimates
%
% Written by:
% Roxy
% March 2017
%
    initial_time = cputime;
    
    % some constants
    EPSILON = 0.1;
    MAX_ITER = 1000;

    % Check inputs
    if nargin <= 1
        disp('EM_Mapping(input_data, size_of_map, Inital_map)/n - at least the first two inputs are required')
        return
    elseif  nargin == 2
        Init_Map = [];
        like_tol = EPSILON;
        iter = MAX_ITER;
    elseif nargin == 3
        like_tol = EPSILON;
        iter = MAX_ITER;
    elseif narin == 4
        like_tol = likelihood_tolerance;
        iter = MAX_ITER;
    elseif narin == 5
        like_tol = likelihood_tolerance;
        iter = max_iterations;
    else 
        disp('EM_Mapping(input_data, size_of_map, Inital_map)/n - at least the first two inputs are required')
        return
    end
    
    % Define size of data set 
    [n,d] = size(input_data);
    % initialise the number of distributions
    k = num_gaussians;
    
    % Initialise: the EM by assigning random gaussian distributions to each
    % variable of the map
    if isempty(Init_Map)
        [Map.weights, Map.mean, Map.covariance, Map.likelihood] = Initialise_Map(input_data, k);
    else
        Map.weights = Init_Map.weights;
        Map.mean = Init_Map.mean;
        Map.covariance = Init_Map.covariance;
        Map.likelihood = Likelihood(input_data, k, Map.weights, Map.mean, Map.covariance);
    end
    Likelihood_n = Likelihood(input_data, k, Map.weights, Map.mean, Map.covariance);
    Likelihood_0 = 2*Likelihood_n;
     % Main loop: iterates until convergence. Implements the E-step and the
     % M-step. Usually 3-5 iterations is sufficient.
     Map.counter = 0;
     while(abs(100*(Likelihood_n-Likelihood_0)/Likelihood_0) > like_tol && Map.counter <= iter)
         % E-Step 
         expectation = E_Step(input_data, k, Map.weights, Map.mean, Map.covariance);
         % M-Step
         [Map.weights, Map.mean, Map.covariance, Map.likelihood] = M_Step(input_data, k, expectation);
         Likelihood_0 = Likelihood_n;
         Likelihood_n = Map.likelihood;
         
         % increment counter for loop conditions
         Map.counter = Map.counter + 1;
     end
     
     Plot_Map(input_data,k,Map.weights,Map.mean,Map.covariance);
     
     disp('Time taken for code: ')
     elapsed_time = cputime-initial_time;
     disp(elapsed_time);  
end
