function [xupd, Pupd] = update(y, xbar, Pbar)
% returns the mean and covariance after correcting based on the
% measurement

K = (Pbar * C')/(C * Pbar * C' + R);
xupd = xbar + K * (y - C * xbar);

I = eye(size(Pbar));
Pupd = (I - K * C) * Pbar * (I - K * C)' + K*R*K';



end