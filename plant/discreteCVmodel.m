function model = discreteCVmodel(q, r)
    % returns a structure that implements a discrete time CV model with
    % continuous time accelleration covariance q and positional
    % measurement with noise with covariance r, both in two dimensions.
    model.f = @(x, Ts) (eye(4) + Ts*diag([1; 1], 2))*x;
    model.F = @(x, Ts) (eye(4) + Ts*diag([1; 1], 2));
    
    model.Q = @(x, Ts) q * [Ts^3/3, 0, Ts^2/2, 0; 0, Ts^3/3, 0, Ts^2/2; Ts^2/2, 0, Ts, 0; 0, Ts^2/2, 0, Ts];
                    
    model.h = @(x) x(1:2);
    model.H = @(x, Ts) [eye(2), zeros(2,2)];
    model.R = @(x, z) r * eye(2);
end