
NN=3;%numver of models
Ts=.001;                           %%Sample time
TH1=10^-6; TH2=10^-6; TH=daug(TH1,TH2);
XI1=1;     XI2=11;     XI=daug(XI1,XI2);

%OK! used in my thesis, Dec 5, 2005
% alfa1=1;                 %fraequency bandwidth of first order filter making disturbance d1 acting on m2
% alfa2=1;                 %fraequency bandwidth of first order filter making disturbance d2 acting on m3

alfa1=.2;                 %fraequency bandwidth of first order filter making disturbance d1 acting on m2
alfa2=.2;                 %fraequency bandwidth of first order filter making disturbance d2 acting on m3
BWx1=1;                 %fraequency bandwidth of first order performance filter on output x1
BWx4=1;                 %fraequency bandwidth of first order performance filter on output x4

% 
% k1_act=1.5;
% m3_act=1;
% P_tau=[0.01 .01 .01 .01 .96]'; % mismatch model-controller at t=tau (no need here!!)
% 
tau=.01;    %delay used in the simulation
smoother=1;%   1 use a low pass filter on parameter estimated by EKF
           %   2 do not use a low pass filter on parameter estimated by EKF

K2_UBTotal=2.5;
K2_LBTotal=.75;
K5_UBTotal=2.5;
K5_LBTotal=.9;
           
           
%% known parameters
m1=1; m4=1;
m2=1; m3=1;
k1=0.15; 
k2 = (2.5-0.75)/2; % Chosen from middle of given interval
k3=0.1; 
k4=0.1; 
k5 = (2.5-0.9)/2; % Chosen from middle of given interval

b1=0.1;  
b2=0.1; 
b3=0.1; 
b4=0.1; 
b5=0.1;

k3_nom=.1; k4_nom=.1;
b3_nom=0.1;  b4_nom =0.1;

% Unused paramters for part 1 - probably relevant for part 2
% k3_LB=.04; k3_UB=.06;
% k4_LB=.04; k4_UB=.06;
% b3_LB=.004; b3_UB=.006;
% b4_LB=.004; b4_UB=.006;

JM1 = 1; 
JM2 = 1; 
JL1 = 1; 
JL2 = 1;

A1 = [0   0   0   0   1   0   0   0   0   0];
A2 = [0   0   0   0   0   1   0   0   0   0];
A3 = [0   0   0   0   0   0   1   0   0   0];
A4 = [0   0   0   0   0   0   0   1   0   0];
A5 = [-(k1+k2+k3)   k2   k3   0   -(b1+b2+b3)   b2   b3   0   1   0]./JL1;
A6 = [k2   -(k2+k4)   0   k4   b2   -(b2+b4)   0   b4   0   0]./JM1;
A7 = [k3   0   -(k3+k5)   k5   b3   0   -(b3+b5)   b5   0   0]./JM2;
A8 = [0   k4   k5   -(k4+k5)   0   b4   b5   -(b5+b5)   0   1]./JL2;
A9 = [0   0   0   0   0   0   0   0   -0.2  0];
A10= [0   0   0   0   0   0   0   1   0   -0.2];

A = [A1;A2;A3;A4;A5;A6;A7;A8;A9;A10];
% Avoid overpopulating workspace
clear A1 A2 A3 A4 A5 A6 A7 A8 A9 A10

B = [
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [1/JM1 0],
    [0 1/JM1],
    [0 0],
    [0 0],
    [0 0]
    ];

G =  [
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [0 0],
    [0.2 0],
    [0 0.2]
    ];