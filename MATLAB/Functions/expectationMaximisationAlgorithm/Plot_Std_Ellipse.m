% plots and ellipse of mean (input_mean) and variance (input_covariance)
function Plot_Std_Ellipse(input_mean,input_covariance)
    [eigenvalues,eigenvectors] = eig(input_covariance);
    d = length(input_mean);
    step_size = 0.001;
    
    % Make covaraince matrix invertable
    if input_covariance(:,:)==zeros(d,d)
        input_covariance(:,:) = ones(d,d)*eps;
    end
    inv_covariance = inv(input_covariance);
    
    % Find the larger projection
    P = [1,0;0,0];  % X-axis projection operator
    P1 = P*2*sqrt(eigenvectors(1,1))*eigenvalues(:,1);
    P2 = P*2*sqrt(eigenvectors(2,2))*eigenvalues(:,2);
    if abs(P1(1)) >= abs(P2(1)),
        Plength = P1(1);
    else
        Plength = P2(1);
    end
    counter = 1;
    step = step_size*Plength;
    Contour1 = zeros(max(2001),2);
    Contour2 = zeros(2001,2);
    for i = -Plength:step:Plength
        a = inv_covariance(2,2);
        b = i*(inv_covariance(1,2) + inv_covariance(2,1));
        c = (i^2)*inv_covariance(1,1) - 1;
        Roots = roots([a, b, c]);
        Root1 = Roots(1);
        Root2 = Roots(2);
        if isreal(Root1),
            Contour1(counter,:) = [i, Root1] + input_mean';
            Contour2(counter,:) = [i, Root2] + input_mean';
            counter = counter + 1;
        end
    end
    if counter > 1
        Contour1 = Contour1(1:counter-1,:);
        Contour2 = [Contour1(1,:);Contour2(1:counter-1,:);Contour1(counter-1,:)];
    end
    plot(input_mean(1),input_mean(2),'b+');
    plot(Contour1(:,1),Contour1(:,2),'b');
    plot(Contour2(:,1),Contour2(:,2),'b');
end