README - INERTIAL MIGRATION SQUARE CHANNEL CODE
Kaitlyn Hood 2014
DOI: 10.5281/zenodo.833532

Cite as:
Kaitlyn Hood. (2017, July 21). kthood/inertial-lift-force-rectangle-AR1: First release of inertial lift force rectangle AR1. Zenodo. http://doi.org/10.5281/zenodo.833532

%——————————————————————————————————————————————————————————————————————————%
getLiftForce_AR1.m

REQUIRES: HoLeal_channel_aspectratio1_Re1_mesh8_12082014.mat

INPUT: 		x 		- x coordinate of center of particle
		y 		- y coordinate of center of particle
		rsph 		- radius of particle
		U		- maximum velocity of background flow
		rho		- fluid density
		L		- side length of square channel
		
OUTPUT:		forcex	- lift force in the x-direction including order rsph^5
		forcey 	- lift force in the y-direction including order rsph^5
		
NOTES:	Results may be inaccurate for large particle radius (rsph > .3L)
		

Code computes the fourth and fifth rider terms of the (inertial) lift force 
of a particle in a square channel.  
Side length of square channel is L, and the coordinates are chosen:
	-.5L < x < .5L, 	-.5L < y < .5L
The result is in dimensional coordinates.

%——————————————————————————————————————————————————————————————————————————%
getLiftForceO4.m

REQUIRES: HoLeal_channel_aspectratio1_Re1_mesh8_12082014.mat

INPUT: 		x 		- x coordinate of center of particle
		y 		- y coordinate of center of particle
		rsph 		- radius of particle
		U		- maximum velocity of background flow
		rho		- fluid density
		L		- side length of square channel
		
OUTPUT:		forcex	- lift force in the x-direction including order rsph^4
		forcey 	- lift force in the y-direction including order rsph^4
		
NOTES:	Results may be inaccurate for moderate to large particle radius
		

Code computes the fourth order term of the (inertial) lift force of a particle 
in a square channel.  
Side length of square channel is L, and the coordinates are chosen:
	-.5L < x < .5L, 	-.5L < y < .5L
The result is in dimensional coordinates.
%——————————————————————————————————————————————————————————————————————————%
getLiftImage_AR1

REQUIRES: HoLeal_channel_aspectratio1_Re1_mesh8_12082014.mat

INPUT: 		x 		- x coordinate of center of particle
		y 		- y coordinate of center of particle
		rsph 		- radius of particle
		L		- side length of square channel

OUTPUT
  v1 - image velocity due to the stokeslet in the x-direction (2x1 vector)
  v2 - image velocity due to the stokeslet in the x-direction (2x1 vector)

NOTES:	Results may be inaccurate for moderate to large particle radius
		

Code computes the image velocities of the (inertial) lift force of a particle 
in a square channel.  
Side length of square channel is L, and the coordinates are chosen:
	-.5L < x < .5L, 	-.5L < y < .5L
The result is in non-dimensional coordinates. 

%——————————————————————————————————————————————————————————————————————————%
liftforce_AR1_channel_plot.m

REQUIRES: 	HoLeal_channel_aspectratio1_Re1_mesh8_03102014.mat
		getLiftForce_AR1.m

INPUT:

OUTPUT:		plot of the lift force field (.eps)

%——————————————————————————————————————————————————————————————————————————%
animation_focusing_AR1.mat

REQUIRES: 	HoLeal_channel_aspectratio1_Re1_mesh8_03102014.mat
		getLiftForceO4.m

INPUT:

OUTPUT:		animation of particles moving according to the lift forces 
		in a square channel (.gif)

%——————————————————————————————————————————————————————————————————————————%

