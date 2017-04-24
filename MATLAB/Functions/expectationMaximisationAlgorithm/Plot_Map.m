% Plots input data points and ellises of mean and variance around clusters
function Plot_Map(input_data,k,input_weight,input_mean,input_covariance)
    [n,d] = size(input_data);
    step_size = 0.001;
    
    if d>2,
        disp('Can only plot 1 or 2 dimensional applications!/n');
        return
    end
    Square_root_variance = zeros(d,k);
    Range_1 = zeros(d,k);
    Range_2 = zeros(d,k);
    for i=1:k,  % Determine plot range as 4 x standard deviations
        Square_root_variance(:,i) = sqrt(diag(input_covariance(:,:,i)));
        Range_1(:,i) = input_mean(:,i) - 4*Square_root_variance(:,i);
        Range_2(:,i) = input_mean(:,i) + 4*Square_root_variance(:,i);
    end
    Range_min = min(min(Range_1));
    Range_max = max(max(Range_2));
    Range = [Range_min:step_size*(Range_max-Range_min):Range_max];
    figure;
    clf;
    hold on
    if d==1,
        Q = zeros(size(Range));
        for i=1:k,
            P = input_weight(i)*normpdf(Range,input_mean(:,i),sqrt(input_covariance(:,:,i)));
            Q = Q + P; 
            plot(Range,P,'r-'); grid on,
        end
        plot(Range,Q,'k-');
        xlabel('X');
        ylabel('Probability density');
    else % d==2
        plot(input_data(:,1),input_data(:,2),'r.');
        for i=1:k,
            Plot_Std_Ellipse(input_mean(:,i),input_covariance(:,:,i));
        end
        xlabel('x');
        ylabel('y');
        axis([Range_min Range_max Range_min Range_max])
    end
    title('Gaussian Probability Distributions of clusters estimated by EM');
end