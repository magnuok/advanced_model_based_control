% Loads all parameters used for the Dynamic Hypothesis testing

ks = [[2.0 2.0]; [1.0 1.75]; [2.0 1.25]]; % Stiffnesses for the different hypotheses

N_hypos = length(ks); % Number of hypytheses
initial_probs = [1.0/N_hypos 1.0/N_hypos 1.0/N_hypos]; % Initialize all probs to uniform

Sh_dets = []; % Determinants of covariance of output estimation vector
Sh_invs = []; % Inverses of covariance of output estimation vector
Ks = [];      % Steady state kalman filter gains for the three hypothesis
PHIS = [];    % Discretization with different stiffness parameters used
DELTAS = [];  % Discretization with different stiffness parameters used

% Continous time matrices from the project description
G_cont = [[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0.2 0];[0 0.2]];
B_cont = [[0 0];[0 0];[0 0];[0 0];[0 0];[1/JM1 0];[0 1/JM1];[0 0];[0 0];[0 0]];
C_const = zeros(2,10); C_const(1,1) = 1; C_const(2,4) = 1; % theta_L1 and _L2

for i = 1:N_hypos
    % Store hypothesis values and discretizations into the different objects 
    
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
    
    % Create state space of the continous time matrices
    sys = ss(a,[B_cont G_cont], C_const, [zeros(2) zeros(2)]);
    
    % Discretize in order to get the steady-state gain and covariance
    [KESTi,Li,Pi,M,Zi] = kalmd(sys,Q,R,Ts);
    
    % Get the discrete time A and B matrix, and add to larger tensor
    [phi_c2d,delta_c2d] = c2d(a,B_cont,Ts);
    PHIS = cat(3,PHIS,phi_c2d); % Does not work with KESTi.A
    DELTAS = cat(3,DELTAS,delta_c2d); % Alternatively KESTi.B(:,1:2)
    
    % Store all kalman gains for the steady-state filters
    Ks = cat(3,Ks,Li);
    
    % Store the measurement covariance determinants and inverses for DHT code
    Shtemp  = C_const*Pi*C_const'+ R./Ts; % Use discretized measurement noise
    Sh_dets = cat(3,Sh_dets,det(Shtemp));
    Sh_invs = cat(3,Sh_invs,inv(Shtemp));
    
end

% Avoid overpopulating workspace
clear A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 p d g