function [A_aug,B_aug,G_aug,C_aug,D_aug,SYS_C,Q,R]=augument_IP_plant(k2,k5)

parameters;

A11=zeros(4);
A12=eye(4);

A21=[[-(k1+k2+k3_nom)       k2       k3_nom        0      ]/m1;    %d1 
     [ k2           -(k2+k4_nom)     0        k4_nom      ]/m2;  % u1
     [ k3_nom                0    -(k3_nom+k5)    k5      ]/m3;  % u2
     [ 0                 k4_nom      k5     -(k4_nom+k5)  ]/m4];   % d2 
   

 A22=[[-(b1+b2+b3_nom)       b2        b3_nom      0    ]/m1;    % d1    
      [    b2         -(b2+b4_nom)     0       b4_nom   ]/m2;   % u1  
      [    b3_nom             0     -(b3_nom+b5)   b5   ]/m3;   % u2
      [    0             b4_nom        b5  -(b4_nom+b5) ]/m4];   % d2 
    

A13=zeros(4,2);
A23=[ 1/m1  0;
       0  0;
       0  0;
       0  1/m4];
   
   A312=zeros(2,8);
    A33=diag([-alfa1 -alfa2]);

A_aug=[A11 A12 A13;
   A21 A22 A23;
   A312 A33];

B_aug=[ 0  0;
    0  0;
    0  0;
    0  0;
    0  0;
    1/m2  0;
    0  1/m3;
    0  0;
    0  0;
    0  0];

G_aug=[ 0  0;
    0  0;
    0  0;
    0  0;
    0  0;
    0  0;
    0  0;
    0  0;
    alfa1  0;
    0  alfa2];

C_aug=[1 0 0 0 0 0 0 0 0 0;
       0 0 0 1 0 0 0 0 0 0];
D_aug=zeros(2);

Q=XI;  %power of disturbance
              R=TH;  %power of measurement noise                   
              SYS_C = ss(A_aug,[B_aug G_aug],C_aug,[D_aug zeros(2,2)]);
