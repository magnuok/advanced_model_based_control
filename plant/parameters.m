% Loads all of the parameters used in the physical model

NN=3;       % Number of models
Ts=.001;    % Sample time
TH1=10^-6; TH2=10^-6; TH=daug(TH1,TH2);
XI1=1;     XI2=11;     XI=daug(XI1,XI2);

%OK! used in my thesis, Dec 5, 2005
% alfa1=1;  % Frequency bandwidth of first order filter making disturbance d1 acting on m2
% alfa2=1;  % Frequency bandwidth of first order filter making disturbance d2 acting on m3
alfa1=.2;   % Frequency bandwidth of first order filter making disturbance d1 acting on m2
alfa2=.2;   % Frequency bandwidth of first order filter making disturbance d2 acting on m3
BWx1=1;     % Frequency bandwidth of first order performance filter on output x1
BWx4=1;     % Frequency bandwidth of first order performance filter on output x4
% cdot
% k1_act=1.5;
% m3_act=1;
% P_tau=[0.01 .01 .01 .01 .96]'; % mismatch model-controller at t=tau (no need here!!)
tau=.01;    %delay used in the simulation
smoother=1;%   1 use a low pass filter on parameter estimated by EKF
           %   2 do not use a low pass filter on parameter estimated by EKF

K2_UBTotal=2.5; K2_LBTotal=.75; K5_UBTotal=2.5; K5_LBTotal=.9;
           
           
%% known parameters
m1 = 1; m4 = 1;
m2 = 1; m3 = 1;
k1 = 0.15; 
k2 = (2.5-0.75)/2; % Chosen from middle of given interval
k3 = 0.1; 
k4 = 0.1; 
k5 = (2.5-0.9)/2; % Chosen from middle of given interval

b1 = 0.1; b2 = 0.1; b3 = 0.1; b4 = 0.1; b5 = 0.1;

k3_nom=.1; k4_nom=.1;
b3_nom=0.1;  b4_nom =0.1;

JM1 = 1; JM2 = 1; JL1 = 1; JL2 = 1;

B = [[0 0];[0 0];[0 0];[0 0];[0 0];[1/JM1 0];[0 1/JM1];[0 0];[0 0];[0 0]];
G = [[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0.2 0];[0 0.2]];
C = zeros(2,10); C(1,1) = 1; C(2,4) = 1; % theta_L1 and theta_L2

% Continous state-space matrices
ks = [[2.0 2.0]; [1.0 1.75]; [2.0 1.25]]; % Stiffnesses for the different hypotheses
N = length(ks);

R = diag([TH1,TH2]) ./ Ts; % Discretized
Q = diag([XI1,XI2],0);  % Symmetrical noise weight matrices
GAMMA = eye(10);

initial_probs = [1.0/N 1.0/N 1.0/N];
Sh_dets = []; % Determinants of covariance of output estimation vector
Sh_invs = []; % Inverses of covariance of output estimation vector
Ks = [];      % Steady state kalman filter gains for the three hypothesis
PHIs = [];    % Discretization with different stiffness parameters used
DELTAs = [];  % Discretization with different stiffness parameters used
Qs = [];  % Discretization with different stiffness parameters used
As = [];      % Store entire state space models
Ps = [];

for i = 1:N
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

    A = [A1;A2;A3;A4;A5;A6;A7;A8;A9;A10];
    
    [PHI, DELTA] = c2d(A,B,Ts);
    % van Loans:
    M = [-A, G*Q*transpose(G);
     zeros(size(A)), transpose(A)]*Ts;
    N = expm(M);
    A_d = N(11:20, 11:20)'; % Same as PHI
    % Note that Q_d is now a 10x10 matrix. => G is 10x1 identity instead.
    Q_d = A_d*N(1:10, 11:20);
    
    PHIs = cat(3,PHIs,PHI);
    DELTAs = cat(3,DELTAs,DELTA);
    Qs = cat(3,Qs,Q_d);

end

% Avoid overpopulating workspace
clear A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 a p d g inmat Pss Kss M N A_d Q_d k2i k5i

% Initial states
initial_state = [0,0,0,0,0,0,0,0,0,0]';
initial_P = initial_state * initial_state';
% Simulation parameters
simNo = 10; % Number between 1 and 10. simNo == 9 means to have constant k2,k5-values, 10 means user defined
simTime = 30;
