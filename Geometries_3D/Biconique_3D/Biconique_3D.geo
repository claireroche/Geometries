Mesh.MshFileVersion=2;
Mesh.Algorithm3D = 10;

c = 299792458;
frequence = 1.4e9;

lambda_vide = c/frequence*1000;
h_vide = lambda_vide/20;

Printf('lambda_vide = %g', lambda_vide);
Printf('h_vide = %g', h_vide);

L  = 1000;
H  = 300;
R2 = 150;
R1 = 50;
Rr = 1000;
th1= 25*Pi/180;
th2= 10*Pi/180;

epaisseurs[] = {};
ninterf = #epaisseurs()+1;

Nrot=3;

x0=0;

alpha = (Sin(th2)*(L-R1-R2) - Cos(th2)*(H-R2) + R1*Cos(th1-th2) - R2)/Sin(th1-th2);
xm = L-R1*(1-Sin(th1)) + alpha*Cos(th1);
ym = R1*Cos(th1) - alpha*Sin(th1);
xc = xm + Rr/Cos((th1-th2)/2)*Cos(Pi/2+(th1+th2)/2);
yc = ym - Rr/Cos((th1-th2)/2)*Sin(Pi/2+(th1+th2)/2);

pc1 = newp; Point(pc1) = {0, 0, -x0+L-R1, h_vide};
pc2 = newp; Point(pc2) = {H-R2, 0, -x0+R2, h_vide};
pcr = newp; Point(pcr) = {yc, 0, xc, h_vide};

p1 = newp; Point(p1) = {0, 0, -x0+L, h_vide};
p2 = newp; Point(p2) = {R1*Cos(th1), 0, -x0+L-R1*(1-Sin(th1)), h_vide};
p3 = newp; Point(p3) = {yc+Rr*Sin(Pi/2+th1), 0, -x0+xc-Rr*Cos(Pi/2+th1), h_vide};
p4 = newp; Point(p4) = {yc+Rr*Sin(Pi/2+th2), 0, -x0+xc-Rr*Cos(Pi/2+th2), h_vide};
p5 = newp; Point(p5) = {H-R2*(1-Cos(th2)), 0, -x0+R2*(1+Sin(th2)), h_vide};
p6 = newp; Point(p6) = {H-R2, 0, -x0, h_vide};
p7 = newp; Point(p7) = {0, 0, -x0, h_vide};

l1 = newl; Circle(l1) = {p1, pc1, p2};
l2 = newl; Line(l2) = {p2, p3};
l3 = newl; Circle(l3) = {p3, pcr, p4};
l4 = newl; Line(l4) = {p4, p5};
l5 = newl; Circle(l5) = {p5, pc2, p6};
l6 = newl; Line(l6) = {p6, p7};

all_lines[] = {l1,l2,l3,l4,l5,l6};
nlines = #all_lines();

eptot=0;
For iep In {0:#epaisseurs()-1}

   eptot += epaisseurs[iep];

   p1 = newp; Point(p1) = {0, 0, -x0+L+eptot, h_vide};
   p2 = newp; Point(p2) = {(R1+eptot)*Cos(th1), 0, -x0+L-R1*(1-Sin(th1))+eptot*Sin(th1), h_vide};
   p3 = newp; Point(p3) = {yc+(Rr+eptot)*Sin(Pi/2+th1), 0, -x0+xc-(Rr+eptot)*Cos(Pi/2+th1), h_vide};
   p4 = newp; Point(p4) = {yc+(Rr+eptot)*Sin(Pi/2+th2), 0, -x0+xc-(Rr+eptot)*Cos(Pi/2+th2), h_vide};
   p5 = newp; Point(p5) = {H-R2*(1-Cos(th2))+eptot*Cos(th2), 0, -x0+R2*(1+Sin(th2))+eptot*Sin(th2), h_vide};
   p6 = newp; Point(p6) = {H-R2, 0, -x0-eptot, h_vide};
   p7 = newp; Point(p7) = {0, 0, -x0-eptot, h_vide};

   l1 = newl; Circle(l1) = {p1, pc1, p2};
   l2 = newl; Line(l2) = {p2, p3};
   l3 = newl; Circle(l3) = {p3, pcr, p4};
   l4 = newl; Line(l4) = {p4, p5};
   l5 = newl; Circle(l5) = {p5, pc2, p6};
   l6 = newl; Line(l6) = {p6, p7};

   all_lines[] = {all_lines[],l1,l2,l3,l4,l5,l6};

EndFor

OLDVAL = Geometry.ExtrudeReturnLateralEntities;
Geometry.ExtrudeReturnLateralEntities = 0;
all_surf[] = {};
For irot In {0:Nrot-1}

   out[] = Extrude {{0,0,1}, {0,0,0}, 2*Pi/Nrot} {
      Line{all_lines[]};
   };

   all_surf[] = {all_surf[], out[{1:2*nlines*ninterf-1:2}]};
   all_lines[] = out[{0:2*nlines*ninterf-1:2}];

EndFor
Geometry.ExtrudeReturnLateralEntities = OLDVAL;

Sint[] = {};
For irot In {0:Nrot-1}
   i0 = irot*nlines*ninterf;
   Sint[] = {Sint[], all_surf[{i0:i0+nlines-1}]};
EndFor
slint = newsl; Surface Loop (slint) = Sint[];
Physical Surface(1) = Sint[];
nv = newv; Volume(nv) = slint;
Physical Volume(1) = nv;

For isurf In {1:ninterf-1}
   Sext[] = {};
   For irot In {0:Nrot-1}
      i0 = (isurf+irot*ninterf)*nlines;
      Sext[] = {Sext[], all_surf[{i0:i0+nlines-1}]};
   EndFor
   slext = newsl; Surface Loop (slext) = Sext[];
   Physical Surface(isurf+1) = Sext[];

   nv = newv; Volume(nv) = {slext,slint};
   Physical Volume(isurf+1) = nv;
   slint = slext;

EndFor
