% close all
% Plots real shart angles vs the kalman estimates ones

% Plots references agains actual values in north, east and yaw
% Simen Sem Oevereng

% Choose degrees or radians for the angle
if true, radconv = 180/pi; else radconv = 1; end

% Choose RGB plotcolor of actual position
clr = [0 0.5 0.9];
clr2 = [0.1 0.8 0.1];

% Find max elements of reference and position 
mx = max(max(z_kalman),max(z_real));
mn = min(min(z_kalman),min(z_real));

% Extract simulation time
t0 = z_kalman.Time; t1 = z_real.Time;

% Setup plotting axis according to the maxes found, and add a slack in case
% of zero-values, which tend to dissapear along the x-axis
as = [0 t1(end)     (mn(1)-1)*1.1            (mx(1)+1e-1)*1.1;
      0 t1(end)     (mn(2)-1)*1.1            (mx(2)+1e-1)*1.1];

figure;

subplot(2,1,1);
p(1) = plot(t0, y_real.Data(:,1), '-g', 'LineWidth',1);
axis(as(1,:))
ax = gca;
ax.FontWeight = 'bold'; 
hold on
p(2) = plot(t1',z_real.Data(:,1),'-r','LineWidth',1.2);
hold on
p(3) = plot(t0,z_kalman.Data(:,1),'-','Color',clr,'LineWidth',1.5);
title('\textbf{Shaft angle} $\theta_1$', 'Interpreter', 'latex', 'FontSize', 13)
legend(p, '\textbf{Real shaft} $\theta_1$ \textbf{angle with noise}', '\textbf{Real shaft angle} $\theta_1$','\textbf{KF estimated shaft angle} $\hat{\theta}_1$', 'Interpreter', 'latex', 'FontSize', 13);
ylabel('\textbf{Shaft angle} $\theta_1$ [deg]', 'Interpreter', 'latex', 'FontSize', 13)
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
grid on
hold off

subplot(2,1,2);
p = plot(t0,-z_real.Data(:,1) + z_kalman.Data(:,1),'-','Color',clr,'LineWidth',1.5);
title('\textbf{Shaft angle error} $\tilde{\theta}_1 = \theta_1 - \hat{\theta}_1$', 'Interpreter', 'latex' , 'FontSize', 13)
ylabel('\textbf{Shaft angle error} $\tilde{\theta}_1$ [deg]', 'Interpreter', 'latex', 'FontSize', 13)
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
ax = gca;
ax.FontWeight = 'bold'; 
grid on
hold off

figure;
subplot(2,1,1);
p(1) = plot(t0, y_real.Data(:,2), '-g', 'LineWidth',1);
axis(as(2,:))
hold on
p(2) = plot(t1,z_real.Data(:,2),'-r','LineWidth',1.2);
hold on
p(3) = plot(t0,z_kalman.Data(:,2),'-','Color',clr,'LineWidth',1.5);
title('\textbf{Shaft angle} $\theta_2$', 'Interpreter', 'latex', 'FontSize', 13)
legend(p, '\textbf{Real shaft} $\theta_2$ \textbf{angle with noise}', '\textbf{Real shaft angle} $\theta_2$','\textbf{KF estimated shaft angle} $\hat{\theta}_2$', 'Interpreter', 'latex', 'FontSize', 13);
ylabel('\textbf{Shaft angle} $\theta_2$ [deg]', 'Interpreter', 'latex', 'FontSize', 13)
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
grid on
hold off

subplot(2,1,2);
p = plot(t0,-z_real.Data(:,2) + z_kalman.Data(:,2),'-','Color',clr,'LineWidth',1.5);
title('\textbf{Shaft angle error} $\tilde{\theta}_2 = \theta_2 - \hat{\theta}_2$', 'Interpreter', 'latex' , 'FontSize', 13)
ylabel('\textbf{Shaft angle error} $\tilde{\theta}_2$ [deg]', 'Interpreter', 'latex', 'FontSize', 13)
xlabel('\textbf{Time} $[s]$', 'Interpreter', 'latex', 'FontSize', 13)
grid on
hold off
