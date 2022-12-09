SetFactory("OpenCASCADE");
Circle(1) = {0, 0, 0, 2.0, 0, 2*Pi};
//
Line Loop (1) = {1};
//
Plane Surface (1) = {1};
//
// Second Cercle
//
Circle(2) = {0, 0, 0, 0.1, 0, 2*Pi};
//
Line Loop (2) = {2};
//
Plane Surface (2) = {2};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }
//
Transfinite Curve {2} = 600;