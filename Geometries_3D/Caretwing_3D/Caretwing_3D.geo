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


