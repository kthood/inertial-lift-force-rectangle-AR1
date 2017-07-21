%% animation_focusing_AR1.m
%  inertial focusing of particles in a square microchannel
%  assuming no noise or particle-particle interactions
%  creates a .gif animation
%
%% AUTHOR
%  Kaitlyn Hood 2014 - kaitlyn.t.hood@gmail.com
%%%

% parameters:
Re = 36;                    % Reynolds number
W = 45e-6; H = 45e-6;       % height and width of channel (m)
rsph = 2.4e-6;              % particle radius (m)
rho0 = 1e3;                 % fluid density (kg/m^3)
mu0 = 1e-3;                 % fluid viscosity (kg/(sm))
U0 = Re*mu0/(rho0*H);       % maximum channel velocity (m/s)
D = (3*pi/Re)*H^4/(rsph^3); % focusing distance (m)
T = 30*D/U0;                % time (s)
N = 300;                    % number of time steps

% non-dimensionalize parameters:
alpha = rsph/H; L=1; AR = W/H; U = 1; rho=1; mu=1; dt = (U0/H)*(T/N);


% determine initial positions of the particles
% uniformly spaced throughout the channel
m1=6; dx=(AR*L-3*alpha)/(m1-1);
m2=6; dy=(L-3*alpha)/(m2-1);
[rx,ry]=meshgrid(-.5*AR*L+1.5*alpha:dx:.5*AR*L-1.5*alpha,...
    -.5*L+1.5*alpha:dy:.5*L-1.5*alpha); 
m=m1*m2; r = zeros(m,2);
for j=1:m2
    for k=1:m1
        index = (j-1)*m1 + k;
        r(index,1) = rx(j,k);
        r(index,2) = ry(j,k);
    end
end

% determine color and size of the particles
M=max(m1,m2);
red = mod(0:m-1,M);
blue = ((1:m) - red - 1)/M;
blue = mod(blue,M);
red=(red+1)/M; blue = (blue+1)/M;
MSize = 255*alpha+15;


% find the lift force field
% to be plotted behind the migrating particles
m1=12; dx=(AR*L-2*alpha-.02*L)/(m1-1);
m2=12; dy=(L-2*alpha-.02*L)/(m2-1);
[xs,ys]=meshgrid(-.5*AR*L+alpha+.01*L:dx:.5*AR*L-alpha-.01*L,...
    -.5*L+alpha+.01*L:dy:.5*L-alpha-.01*L);
forcex = zeros(size(xs)); forcey = zeros(size(ys));
for j=1:size(xs,1)
    for l=1:size(xs,2)
        [forcex(j,l),forcey(j,l)]=getLiftForce_AR1(xs(j,l),ys(j,l),alpha,U,rho,L);
    end
end


% Advect particles using the lift force
x=zeros(m,N); y=zeros(m,N);
u =zeros(m,1); v=zeros(m,1);
x(:,1)=r(:,1); y(:,1)=r(:,2); 
for j=2:N;
    j
    for k=1:m
        try
            drag = 6*pi*mu*alpha;
            [utemp,vtemp] = getLiftForce_AR1(x(k,j-1),y(k,j-1),alpha,U,rho,L);
            V = [utemp; vtemp]/drag;
            [v1,v2] = getLiftImage_AR1(x(k,j-1),y(k,j-1),alpha,L);
            v1 = alpha*v1*abs(V(1)); 
            v2 = alpha*v2*abs(V(2));
            vel = V + v1 + v2;
            u(k) = vel(1); 
            v(k) = vel(2);
        catch
            u(k) = 0;
            v(k) = 0;
        end
    end
    x(:,j) = x(:,j-1)+dt*u;
    y(:,j) = y(:,j-1)+dt*v;
end


% plot the lift force field
% plot the particle positions at each time
% save series of plots as a .gif
figure('Units','pixels','Position',[100,100,275,275])
clf
filename = ['animation_liftforce_AR2_alpha',num2str(alpha),'_Re',num2str(Re),'_m',num2str(m),'.gif'];
frame_rate = 10; 
for n = 1:N/frame_rate
    %re-dimensionalize
    h=H*10^6;
    clf
    hold all
    % plot lift force field arrows
    quiver(h*xs,h*ys,h*forcex,h*forcey)

    % plot the particles at this time
    for j=1:m
        plot(h*x(j,1+frame_rate*(n-1)),h*y(j,1+frame_rate*(n-1)),...
            'ko','MarkerSize',MSize,'MarkerFaceColor',[0,red(j),blue(j)])
    end

    % plot formatting
    set(gca,'XLim',[-.5*AR*L*h,.5*AR*L*h])
    set(gca,'YLim',[-.5*L*h,.5*L*h])
    xaxis=L*h*(-1:.1:1);
    plot(xaxis, zeros(size(xaxis)),'k-')
    plot(zeros(size(xaxis)),xaxis,'k-')
    plot(xaxis, .5*L*h*ones(size(xaxis)),'k-')
    plot(xaxis, -.5*L*h*ones(size(xaxis)),'k-')
    xlabel('x (\mum)')
    ylabel('y (\mum)')
    box on
    axis square
    title(['Re = ',num2str(Re),', a = ',num2str(rsph/(10^-6)),'\mum'])

    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if n == 1;
         imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',.01);
    else
         imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',.01);
    end
end



