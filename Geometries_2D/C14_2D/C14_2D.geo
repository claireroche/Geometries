SetFactory("OpenCASCADE");
Circle(1) = {0, 0, 0, 2.0, Pi/2.0, -Pi/2.0};
Point(20) = {0, 2.0, 0};
Point(30) = {6.0, 2.0, 0};
Point(40) = {6.0, -2.0, 0};
Point(50) = {0, -2.0, 0};
Line(6) = {20, 30};
Line(7) = {30, 40};
Line(8) = {40, 50};
//
Line Loop (1) = {1, 6, 7, 8};
//
Plane Surface (1) = {1};
//
// Second Cercle
//
Circle(2) = {0.0, 0, 0, 0.1, 0, 2*Pi};
//
Line Loop (2) = {2};
//
Plane Surface (2) = {2};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }
//
Transfinite Curve {2} = 400;