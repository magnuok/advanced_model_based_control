% Store the steady state Kalman filter gains and covariance for the DHT
% NB: Only run this file if scenario 9 has been simulated first!

[~,~,el] = size(K.Data);
K_ss = K.Data(:,:,el);

[~,~,el] = size(P.Data);
P_ss = P.Data(:,:,el);

save('ss3.mat','K_ss','P_ss');