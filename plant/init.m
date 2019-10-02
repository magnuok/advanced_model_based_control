clc
clear all
close all
parameters;
%plotarea

%%  Load and descretize GNARC
load('GNARC1.mat');
[A_C,B_C,C_C,D_C]=ssdata(Km);
[A_D,B_D]=c2d(A_C,B_C,Ts);
C_D=C_C;
D_D=D_C;
GRED = bstmr(Km,35);
[A_C_Re,B_C_Re,C_C_Re,D_C_Re]=ssdata(GRED);
[A_D_Re_GNARC,B_D_Re_GNARC]=c2d(A_C_Re,B_C_Re,Ts);
C_D_Re_GNARC=C_C_Re;
D_D_Re_GNARC=D_C_Re;
 

clear A_C B_C C_C D_C A_D B_D C_D D_D Ap Km k2_LB k2_UB k5_LB k5_UB mu_m


%  Load and descretize LNARCs
load('LNARC1.mat');
[A_C,B_C,C_C,D_C]=ssdata(Km);
[A_D,B_D]=c2d(A_C,B_C,Ts);
C_D=C_C;
D_D=D_C;
GRED = bstmr(Km,23);
[A_C_Re,B_C_Re,C_C_Re,D_C_Re]=ssdata(GRED);
[A_D_Re_LNARC1,B_D_Re_LNARC1]=c2d(A_C_Re,B_C_Re,Ts);
C_D_Re_LNARC1=C_C_Re;
D_D_Re_LNARC1=D_C_Re;
 
clear A_C B_C C_C D_C A_D B_D C_D D_D Ap Km k2_LB k2_UB k5_LB k5_UB mu_m
 
load('LNARC2.mat');
[A_C,B_C,C_C,D_C]=ssdata(Km);
[A_D,B_D]=c2d(A_C,B_C,Ts);
C_D=C_C;
D_D=D_C;
GRED = bstmr(Km,20);
[A_C_Re,B_C_Re,C_C_Re,D_C_Re]=ssdata(GRED);
[A_D_Re_LNARC2,B_D_Re_LNARC2]=c2d(A_C_Re,B_C_Re,Ts);
C_D_Re_LNARC2=C_C_Re;
D_D_Re_LNARC2=D_C_Re;
 
clear A_C B_C C_C D_C A_D B_D C_D D_D Ap Km k2_LB k2_UB k5_LB k5_UB mu_m



load('LNARC3.mat');
[A_C,B_C,C_C,D_C]=ssdata(Km);
[A_D,B_D]=c2d(A_C,B_C,Ts);
C_D=C_C;
D_D=D_C;
GRED = bstmr(Km,26);
[A_C_Re,B_C_Re,C_C_Re,D_C_Re]=ssdata(GRED);
[A_D_Re_LNARC3,B_D_Re_LNARC3]=c2d(A_C_Re,B_C_Re,Ts);
C_D_Re_LNARC3=C_C_Re;
D_D_Re_LNARC3=D_C_Re;
 
clear A_C B_C C_C D_C A_D B_D C_D D_D Ap Km k2_LB k2_UB k5_LB k5_UB mu_m

