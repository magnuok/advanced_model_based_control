function [xbar, Pbar] = predict(xhat, Phat, u)
% returns the predicted mean (=state) and covariance (-covariance of 
% predicted state estimate error)for a time step Ts

% xp = x_predicted

% PREDICTION
xbar = PHI * xhat + DELTA * u;
Pbar = PHI * Phat * PHI' + GAMMA * Q * GAMMA';


end