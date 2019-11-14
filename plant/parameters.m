% Loads all of the parameters used in the physical model

NN=3;       % Number of models
Ts=.001;    % Sample time
TH1=10^-6; TH2=10^-6; TH=daug(TH1,TH2); % Continous time
XI1=1;     XI2=11;     XI=daug(XI1,XI2); % Continous time

%OK! used in my thesis, Dec 5, 2005
% alfa1=1;    % Frequency bandwidth of first order filter making disturbance d1 acting on m2
% alfa2=1;    % Frequency bandwidth of first order filter making disturbance d2 acting on m3
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

% Continous time state-space matrices
B = [[0 0];[0 0];[0 0];[0 0];[0 0];[1/JM1 0];[0 1/JM1];[0 0];[0 0];[0 0]];
G = [[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0 0];[0.2 0];[0 0.2]];
C = zeros(2,10); C(1,1) = 1; C(2,4) = 1; % theta_L1 and theta_L2

A1 = [0   0   0   0   1   0   0   0   0   0];
A2 = [0   0   0   0   0   1   0   0   0   0];
A3 = [0   0   0   0   0   0   1   0   0   0];
A4 = [0   0   0   0   0   0   0   1   0   0];
A5 = [-(k1+k2+k3)   k2      k3         0   -(b1+b2+b3)    b2        b3      0     1   0]./JL1;
A6 = [k2         -(k2+k4)    0         k4      b2      -(b2+b4)     0       b4    0   0]./JM1;
A7 = [k3             0    -(k3+k5)     k5      b3         0      -(b3+b5)   b5    0   0]./JM2;
A8 = [0              k4     k5     -(k4+k5)    0          b4        b5   -(b4+b5) 0   1]./JL2;
A9 = [0   0   0   0   0   0   0   0   -0.2  0];
A10= [0   0   0   0   0   0   0   0   0   -0.2];

A = [A1;A2;A3;A4;A5;A6;A7;A8;A9;A10];

% Measurement and process noise matrices
R = diag([TH1,TH2]);    % Continous time measurement noise matrix
Rd = R ./ Ts;           % Discrete time
Q = diag([XI1,XI2],0);  % Continous time. Symmetrical noise weight matrices

% Obtain discrete-time A and B
[PHI, DELTA] = c2d(A,B,Ts);

% van Loans method for discretizing Q: https://wolfweb.unr.edu/~fadali/EE782/NumEvalQphi.pdf
GAMMA = eye(10);
M = [-A, G*Q*transpose(G);
     zeros(size(A)), transpose(A)]*Ts;
N = expm(M);
A_d = N(11:20, 11:20)'; % Same as PHI
% Note that Q_d is now a 10x10 matrix. => G is 10x1 identity instead.
Qd = A_d*N(1:10, 11:20); % Discrete time system noise matrix

% Avoid overpopulating workspace
clear A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 M A_d

% Initial states
initial_state = [0,0,0,0,0,0,0,0,0,0]';

% Initial covariance matrix. Can be all zeros or a converged matrix from
% previous test run.

% initial_P = initial_state * initial_state';
inmat = load('ss.mat');
initial_P = inmat.P_ss;
clear inmat

% Load parameters for Dynamic Hypothesis Testing
dht;

% Simulation parameters
% Number between 1 and 10. simNo == 9 means to have constant k2,k5-values, 10 means step changes in spring stiffnesses
simNo = 5; 
simTime = 300;

% For a quick simulation from the command window, qsim can be used. For
% immediately plotting, run: qsim; plotref; plotprobs;
