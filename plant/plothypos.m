% Plots the three hypotheses angle estimations

figure;
data = yest.Data;
[rr,cc,tt] = size(data);
clrprob = [[0.3010, 0.7450, 0.9330];[0.8500, 0.3250, 0.0980];[0.8, 0.0780, 0.1840]];
for i = 1:N
    subplot(3,1,i)
    pltdata = reshape(data(:,i,:),[2,tt]);
    ppp = plot(yest.Time,pltdata,'Color',clrprob(i,:));
    hold on
    ppp = plot(z_real.Time,z_real.Data);
    title('Hypothesis no. ' + string(i))
    
end

% Calculate the mean rms over all time instances for each hypothesis
zplt = z_real.Data';
[a,b] = size(z_real.Data);
errors = zeros(3,a);

for i = 1:a
    for j = 1:cc
        errors(j,i) = rms(zplt(:,i) - reshape(data(:,j,i),[2 1]));
    end
end

avgerrors = sum(errors,2) / a;
