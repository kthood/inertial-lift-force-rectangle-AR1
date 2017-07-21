function [v1,v2]=getLiftImage_AR1(x,y,rsph,L)
%% INPUT:
%  Dimensions -.5L < x < .5L, -.5L < y < .5L
%  rsph is the particle radius (rsph < .5L)
%  U is the maximum velocity in the channel
%  L is the side length of the square channel
%
%% OUTPUT
%  v1 - image velocity due to the stokeslet in the x-direction (2x1 vector)
%  v2 - image velocity due to the stokeslet in the x-direction (2x1 vector)
%
%% DEPENDENCIES
%  Need to have HoLeal_channel_AR1_Re1_mesh8_05-14-15.mat in the Matlab path
%  Uses Matlab's interp2 for 2D interpolation
%
%% NOTES
%  Results may be inaccurate for large particle radius
%  i.e. rsph > .2L
%
%  Code will return an error if particle radius (rsph) and location
%  (x,y) are chosen such that the particle hits the wall. 
%
%% AUTHOR
%  Kaitlyn Hood 2014 - kaitlyn.t.hood@gmail.com
%%

% if the location (x,y) is outside the channel, return an error
if x<-L/2 || x>L/2 || y<-L/2 || y>L/2
    error(['location outside channel: pick ',num2str(-L/2),' < x < ',num2str(L/2),' and ',num2str(-L/2),' < y < ',num2str(L/2)])
% if the particle is too big and hits the wall, return an error
elseif rsph>(.5*L-max(abs(x),abs(y)))
    error(['particle is too close to wall: choose rsph < ' num2str(.5*L-max(abs(x),abs(y)))])
% otherwise proceed
else
    % if the particle radius is large, return a warning
    if rsph/L > 0.23
        warning('large particle radius, results may be inaccurate')
    end
    
    x=x/L; y=y/L;

    load HoLeal_channel_AR1_Re1_mesh8_05-14-15.mat
    sxx = Sxx;
    sxy = Sxy;
    syx = Syx;
    syy = Syy;
    locx=xloc; locy=yloc;

    Axx = interp2(locx,locy,sxx,abs(x),abs(y));
    Axy = interp2(locx,locy,sxy,abs(x),abs(y));
    Ayx = interp2(locx,locy,syx,abs(x),abs(y));
    Ayy = interp2(locx,locy,syy,abs(x),abs(y));
    
    if x<0 && y<0
        Axx = -Axx;
        Axy = -Axy;
        Ayx = -Ayx;
        Ayy = -Ayy;
    elseif x>0 && y<0
        Axy = -Axy;
        Ayy = -Ayy;
    elseif x<0 && y>0
        Axx = -Axx;
        Ayx = -Ayx;
    end
    
    v1 = [Axx; Axy];
    v2 = [Ayx; Ayy];
end

return
