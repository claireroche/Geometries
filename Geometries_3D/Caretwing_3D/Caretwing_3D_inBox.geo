//+ Caret-wing design from Kuchemann, Dietrich
//+
SetFactory("OpenCASCADE");
//+
mach    = 10.0;
finesse = 10.0;
tau     = 0.06;
//+sOverL  = 0.3;
gamma   = 1.4;
//+
L       = 1.0;
//+
delta   = Atan(1.0/finesse); // delta in Radians
sOverL  = 1.0 / ((finesse * 3.0 * tau)*(finesse * 3.0 * tau));
s       = sOverL * L;
//+
sigma   = 10.162570 * Pi / 180.0; // from caretwing.py, in Radians
//+
//+
Point(1) = {0, 0, 0, 1}; // nose
Point(2) = {L * Cos(sigma), L * Sin(sigma), 0, 1}; // top of caret
Point(3) = {L * Cos(sigma), L * (Sin(sigma) - Sin(delta)), 0, 1}; // bottom of caret
Point(4) = {L * Cos(sigma), 0, s, 1};
Point(5) = {L * Cos(sigma), 0, -s, 1};
//+
Line(1) = {2, 4};
Line(2) = {4, 3};
Line(3) = {3, 5};
Line(4) = {5, 2};
Line(5) = {1, 2};
Line(6) = {1, 4};
Line(7) = {1, 5};
Line(8) = {1, 3};
//+
Curve Loop(1) = {1, 2, 3, 4};
Surface(1)    = {1};
Curve Loop(5) = {5, -4, -7};
Surface(2) = {5};
Curve Loop(7) = {5, 1, -6};
Surface(3) = {7};
Curve Loop(9) = {7, -3, -8};
Surface(4) = {9};
Curve Loop(11) = {8, -2, -6};
Surface(5) = {11};
//+
Surface Loop(1) = {3, 2, 4, 1, 5};
Volume(1) = {1};
//+
Box(2) = {-0.2, -0.3, -0.45, 2.2, 0.8, 0.9};
//+
BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; }
//+
Physical Surface("Inlet") = {6};
Physical Surface("Outlet") = {9, 10, 7, 11, 8};
Physical Surface("Wall") = {5, 3, 2, 1, 4};
Physical Volume("Fluid") = {2};
//+
factor_far = 40;
factor_body = 120;
//-- BOX
// Length 2.2 (X)
Transfinite Curve {15, 16, 18, 13} = 2.2 * factor_far;
// Length 0.8 (Y)
Transfinite Curve {12, 10, 17, 20} = 0.8 * factor_far;
// Length 0.9 (Z)
Transfinite Curve {9, 14, 19, 11} = 0.9 * factor_far;
//-- OBJECT
// Length L (longi)
Transfinite Curve {5, 6, 7, 8} = L * factor_body;
// Length
Transfinite Curve {1, 2, 3, 4} = s * factor_body;


