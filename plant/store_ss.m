% Store the steady state Kalman filter gains and covariance for the DHT
% NB: Only run this file if scenario 9 has been simulated first!

K_ss = K_out.Data(:,:,end);
P_ss = P_out.Data(:,:,end);

save('ss.mat','K_ss','P_ss');