% Nathan Lavoy
% 100995612
clear all
clearvars
close all

q = 1.60217653e-19;             % electron charge
m = 9.10938215e-31;             % electron mass
field = 1e-8;
prob = [0.05 0.07 0.09 0.1];
y = [0 .01 .02 .03];

%Position
xinit = [0 0 0 0];
xcur = xinit;


vinit = [0 0 0 0];
vcur = vinit;
driftv = [0 0 0 0];

tcur = 0;
dt = 0.001;

iter = 200;

for i=1:iter
    hold on;
    for j=1:length(y)
        if scatter(prob(j)) == true
            vcur(j) = 0;
        else
            force = q*field;
            accel = force/m;
            dv = accel * dt;
            vcur(j) = vcur(j) + dv;
            xcur(j) = xcur(j) + vcur(j)*dt; 
        end
        pause(0.01)
        subplot(2,1,1);
        plot(xcur(j),y(j), 'Marker', 'o')
        xlim([0 6]);
        ylim([-0.01 0.04]);
        hold on
        
        driftv = sum(vcur)/tcur;
        
        subplot(2,1,2)
        plot(tcur, vcur(j), 'Marker', 'o');
        tcur = tcur + dt;
        t = strcat('Drift Velocity:', num2str(driftv));
        title(t);
    end
    hold off
end
function occur = scatter(prob)
    x = rand;
    occur = false;
    if x < prob
        occur = true;
    end    
end