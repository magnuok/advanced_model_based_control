figure;
grid on;

for i = 1:length(K.Time)
   K_data11(i) = K.Data(1,1,i);
   K_data14(i) = K.Data(4,1,i);
   K_data21(i) = K.Data(1,2,i);
   K_data24(i) = K.Data(4,2,i); 
end

% Find max elements of reference and position 
mx(1) = max(max(K_data11),max(K_data14));
mn(1) = min(min(K_data11),min(K_data14));

mx(2) = max(max(K_data21),max(K_data24));
mn(2) = min(min(K_data21),min(K_data24));


% Extract simulation time
t0 = K.Time;

% Setup plotting axis according to the maxes found, and add a slack in case
% of zero-values, which tend to dissapear along the x-axis
as1 = [0 t0(end)     (mn(1)-1e-3)*1.1            (mx(1)+1e-3)*1.1;
      0 t0(end)     (mn(1)-1e-3)*1.1            (mx(1)+1e-3)*1.1];

as2 = [0 t0(end)     (mn(2)-1e-3)*1.1            (mx(2)+1e-3)*1.1;
      0 t0(end)     (mn(2)-1e-3)*1.1            (mx(2)+1e-3)*1.1];  

subplot(2,1,1);
p(1) = plot(K.Time, K_data11, '-r', 'LineWidth',1.5); hold on;
p(2) = plot(K.Time, K_data14, '-b', 'LineWidth',1.5); hold on;
title('\textbf{Kalman gains for} $\theta_1$', 'Interpreter', 'latex', 'FontSize', 13);
legend(p,'$K_{1,1}$', '$K_{1,4}$', 'Interpreter', 'latex', 'FontSize', 13);
ylabel('\textbf{Gain value} $[]$', 'Interpreter', 'latex', 'FontSize', 13);
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
grid on
axis(as1(1,:))
ax = gca;
ax.FontWeight = 'bold'; 

subplot(2,1,2);
p(1) = plot(K.Time, K_data21, '-r', 'LineWidth',1.5); hold on;
p(2) = plot(K.Time, K_data24, '-b', 'LineWidth',1.5); hold on;
title('\textbf{Kalman gains for} $\theta_2$', 'Interpreter', 'latex', 'FontSize', 13);
legend(p,'$K_{2,1}$', '$K_{2,4}$', 'Interpreter', 'latex', 'FontSize', 13);
ylabel('\textbf{Gain value} $[]$', 'Interpreter', 'latex', 'FontSize', 13);
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
axis(as2(1,:))
ax = gca;
ax.FontWeight = 'bold'; 

grid on
hold off