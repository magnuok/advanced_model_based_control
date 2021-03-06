% Plots the different hypothesis' probabilities over time

% Nice colors
clrprob = [[0.3010, 0.7450, 0.9330];
            [0.8500, 0.3250, 0.0980];
            [0.8, 0.0780, 0.1840]];
clrks = [[0.4940, 0.1840, 0.5560];
        [0.4660, 0.6740, 0.1880];...
         [0, 0.4470, 0.7410];
         [0.9290, 0.6940, 0.1250]];

for i = 1:N_hypos
    % Plot probabilities
    figure(8)
    subplot(3,1,i);
    p1 = plot(probs.Time,probs.Data(:,i), 'Color',clrprob(i,:),'LineWidth',3);
    ylabel('Probability')
    xlabel('Time [s]')
    title('Hypothesis ' + string(i))
    grid on
    
    % Plot spring stiffnesses
    figure(9)
    subplot(3,1,i)
    p2(1) = plot(k2out.Time,k2out.Data,'Color',clrprob(1,:),'LineWidth',3);
    hold on 
    p2(2) = plot(k5out.Time,k5out.Data,'Color',clrprob(3,:),'LineWidth',3);
    hold on
    p2(3) = plot(k2out.Time,ones(1,length(k2out.Time)) .* ks(i,1),'--','Color',clrprob(1,:),'LineWidth',2);
    hold on
    p2(4) = plot(k5out.Time,ones(1,length(k5out.Time)) .* ks(i,2),'--','Color',clrprob(3,:),'LineWidth',2);
    legend(p2, 'k2 real','k5 real','k2 hypothesis','k5 hypothesis')
    xlabel('Time [s]')
    ylabel('Spring stiffness')
    title('Hypothesis ' + string(i) + ' stiffness vs real stiffness')
    axis([0 k5out.Time(end) 0.8 2.1])
end

clear p1 p2

