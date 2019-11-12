ks = [[2.0 2.0]; [1.0 1.75]; [2.0 1.25]]; % Stiffnesses for the different hypotheses

N = length(ks);
initial_probs = [1.0/N 1.0/N 1.0/N];

Sh_dets = []; % Determinants of covariance of output estimation vector
Sh_invs = []; % Inverses of covariance of output estimation vector
Ks = [];      % Steady state kalman filter gains for the three hypothesis
PHIS = [];    % Discretization with different stiffness parameters used
DELTAS = [];  % Discretization with different stiffness parameters used
GAMMAS = [];  % Discretization with different stiffness parameters used
As = [];      % Store entire state space models
Ps = [];

for i = 1:N
    % Store hypothesis values and discretizations into the different objects 
%     inmat   = load('ss' + string(i));
%     Ks      = [Ks inmat.K_ss];
%     Shtemp  = C * inmat.P_ss * C'+ R;
%     Sh_dets = [Sh_dets det(Shtemp)];
%     Sh_invs = [Sh_invs inv(Shtemp)];
    
    k2i = ks(i,1);
    k5i = ks(i,2);
    
    A1 = [0   0   0   0   1   0   0   0   0   0];
    A2 = [0   0   0   0   0   1   0   0   0   0];
    A3 = [0   0   0   0   0   0   1   0   0   0];
    A4 = [0   0   0   0   0   0   0   1   0   0];
    A5 = [-(k1+k2i+k3)   k2i     k3          0   -(b1+b2+b3)   b2        b3      0     1   0]./JL1;
    A6 = [k2i        -(k2i+k4)    0         k4       b2     -(b2+b4)     0       b4    0   0]./JM1;
    A7 = [k3             0     -(k3+k5i)    k5i      b3        0      -(b3+b5)   b5    0   0]./JM2;
    A8 = [0              k4      k5i     -(k4+k5i)   0         b4        b5   -(b4+b5) 0   1]./JL2;
    A9 = [0   0   0   0   0   0   0   0   -0.2  0];
    A10= [0   0   0   0   0   0   0   0   0   -0.2];

    a = [A1;A2;A3;A4;A5;A6;A7;A8;A9;A10];
    
    sys = ss(a,[B G], C, [zeros(2) zeros(2)]);
    [KESTi,Li,Pi,M,Z] = kalmd(sys,Q,R,Ts);
    PHIS = cat(3,PHIS,KESTi.A);
    DELTAS = cat(3,DELTAS,KESTi.B(:,1:2));
    Ks = [Ks Li];
    Shtemp  = C * Pi * C'+ R;
    Sh_dets = [Sh_dets det(Shtemp)];
    Sh_invs = [Sh_invs inv(Shtemp)];
    
    %KEST.C
    
    
    % Append
    % [p, d] = c2d(a,B,Ts);
%     PHIS = cat(3,PHIS,p);
%     DELTAS = cat(3,DELTAS,d);   
%     As = [As a];
end

% Avoid overpopulating workspace
clear A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 a p d g inmat Pss Kss