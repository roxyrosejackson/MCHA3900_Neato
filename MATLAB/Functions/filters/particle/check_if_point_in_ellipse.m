function inside_ellipse = check_if_point_in_ellipse(input_point, input_mean, input_covariance)

    global param
    
    chi_square = sqrt(chi2inv(param.confidenceInterval, param.degreesOfFreedom));
    
    [eigenvectors, eigenvalues] = eig(input_covariance);
    
    location = mod(find(eigenvalues == max(max(eigenvalues))),2) + 2*(~(mod(find(eigenvalues == max(max(eigenvalues))),2)));
    
    dominant_eigenvector = eigenvectors(:,location);
    dominant_eigenvalue = eigenvalues(location,location);
    
    nondominant_eigenvector = eigenvectors(:,mod(location,2)+1);
    nondominant_eigenvalue = eigenvalues(mod(location,2)+1,mod(location,2)+1);
    
    alpha = atan2(real(dominant_eigenvector(2)),real(dominant_eigenvector(1)));
    
    if (alpha < 0)
       alpha = alpha + 2*pi; 
    end
    
    a = chi_square*sqrt(dominant_eigenvalue);
    b = chi_square*sqrt(nondominant_eigenvalue);
    
    inside_ellipse = (((cos(alpha)*(input_point(1)-input_mean(1))+sin(alpha)*(input_point(2)-input_mean(2)))^2/a^2 + (sin(alpha)*(input_point(1)-input_mean(1))-cos(alpha)*(input_point(2)-input_mean(2)))^2/b^2)<=1);

end