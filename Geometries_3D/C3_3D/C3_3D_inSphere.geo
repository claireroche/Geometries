//+
SetFactory("OpenCASCADE");
//
//	Cube interne
//
Box(20) = {-0.5, -0.5, -0.5, 1, 1, 1};
Physical Volume(2) = {20};
Box(21) = {0, 0, 0, 0.5, 0.5, 0.5};
Physical Volume(3) = {21};
//
// Trou
//
BooleanDifference{ Physical Volume{2}; Delete; }{ Physical Volume{3}; Delete; }
//
//
//	Sphere externe
//
//
Sphere(10) = {0, 0, 0, 4, -Pi/2, Pi/2, 2*Pi};
Physical Volume(10) = {10};
BooleanDifference{ Physical Volume{10}; Delete; }{ Physical Volume{2}; Delete; }