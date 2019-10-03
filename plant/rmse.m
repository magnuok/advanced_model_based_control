% Calculates root squared mean error of kalman filter esimates
 
% (y - yhat)    % Errors
% (y - yhat).^2   % Squared Error
% mean((y - yhat).^2)   % Mean Squared Error
% RMSE = sqrt(mean((y - yhat).^2));  % Root Mean Squared Error

rmse1 = sqrt( mean((z_kalman.Data(:,1) - z_real.Data(:,1)).^2));
rmse2 = sqrt( mean((z_kalman.Data(:,2) - z_real.Data(:,2)).^2));

RMSE = [rmse1 rmse2]