function Plot_Ellipse(input_mean, input_covariance)

    alpha = linspace(0,2*pi,100);
    circle = [cos(alpha); sin(alpha)];
    C = chol(input_covariance);
    ellipse = C*circle;
    
    X = input_mean(1) + ellipse(1,:);
    Y = input_mean(2) + ellipse(2,:);
    
    plot(input_mean(1),input_mean(2),'b+');
    plot(X,Y,'k');
    
end