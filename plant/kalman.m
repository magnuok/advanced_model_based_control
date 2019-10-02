% set parameters
q = 4;
r = 10;
% create the model and estimator object
model = discreteCVmodel (q , r) ;
ekf = EKF ( model );
% initialize
xbar(:, 1) = [0 , 0 , 1, 1 ]';
Pbar(:, :, 1) = diag([50 , 50 , 10 , 10].^2) ;
% estimate
for k = 1: K
    [xhat(:, k), Phat(:, :,k) ] = ekf.update(Z(:, k), xbar(:, k), Pbar(:, :, k));
        if k < K
            [xbar(:, k + 1), Pbar(: ,: ,k + 1)] = ekf.predict(xhat(: , k), Phat(:, :, k), Ts ) ;
        end
end


% calculate a performance metric
%posRMSE = sqrt ( mean ( sum (( xhat (1:2 , :) - Xgt (1:2 , :) ) .^2 , 1) ) ); %
%position RMSE
%velRMSE = sqrt ( mean ( sum (( xhat (3:4 , :) - Xgt (3:4 , :) ) .^2 , 1) ) ); %
%velocity RMSE