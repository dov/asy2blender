//======================================================================
// An asymptote program creating a connected spiral ball path
//
// This script is licensed under the GNU Lesser Public License 3.
//
// Dov Grobgeld <dov.grobgeld@gmail.com>
// 2022-05-30 Mon
//----------------------------------------------------------------------

import path_utils; import three; import graph3;

real tmax = 7.;

real r(real t) { return 0.1 + sqrt((tmax/2)**2-(t-tmax/2)**2); }

real x(real t) {return cos(2pi*t)*r(t);}
real y(real t) {return sin(2pi*t)*r(t);}
real z(real t) {return t;}


path3 p=((0,0,1)
         ..graph(x,y,z,0,tmax,operator ::)
         ..(0,0,tmax-1)
         ---cycle);
save_path3(p, 'spiral.json');

