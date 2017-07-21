% Plots the lift force field in a square channel
% Kaitlyn Hood 2014

Re = 36;            % Reynolds number
L = 45e-6;          % Channel width (m)
rsph = 6e-6;        % particle radus (m)
rho = 1e3;          % fluid density (kg/m^3)
mu = 1e-3;          % fluid viscosity (kg/(ms))
U = Re*mu/(rho*L);  % maximum channel velocity (m/s)

[xs,ys]=meshgrid(-.5*L+rsph+.01*L:.05*L:.5*L-rsph-.01*L);
forcex = zeros(size(xs)); forcey = zeros(size(ys));
for j=1:size(xs,1)
    for l=1:size(xs,2)
        [forcex(j,l),forcey(j,l)]=getLiftForce_AR1(xs(j,l),ys(j,l),rsph,U,rho,L);
    end
end

figure('Units', 'pixels', 'Position', [100 400 300 300]);
h=10^6;
hold on
quiver(h*xs,h*ys,h*forcex,h*forcey)
set(gca,'XLim',[-.5*L*h,.5*L*h])
set(gca,'YLim',[-.5*L*h,.5*L*h])
xaxis=L*h*(-.5:.1:.5);
plot(xaxis, zeros(size(xaxis)),'k-')
plot(zeros(size(xaxis)),xaxis,'k-')
axis square
box on
xlabel('x (\mum)')
ylabel('y (\mum)')
title(['Re = ',num2str(Re),', a = ',num2str(rsph/(10^-6)),'\mum'])
