
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
k1=0.15; %k3=1; k4=0.2; 
b1=0.1;  b2=0.1;   b5 =0.1;
k3_nom=.1; k4_nom=.1;
b3_nom=0.1;  b4_nom =0.1;

% k3_LB=.04; k3_UB=.06;
% k4_LB=.04; k4_UB=.06;
% 
% b3_LB=.004; b3_UB=.006;
% b4_LB=.004; b4_UB=.006;

