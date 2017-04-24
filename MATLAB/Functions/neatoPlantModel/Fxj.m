function F = Fxj(idx)
    global param;
    parameters;

    
    F = zeros(param.n_states + 2*1, param.n_states + 2*param.n_points);
    F(1:param.n_states, 1:param.n_states) = eye(param.n_states)
    F(param.n_states+1:(param.n_states + 2*1), param.n_states + 2*idx:param.n_states + 2*idx+1)  = eye(2*1);


end