//+
SetFactory("OpenCASCADE");
//
//	Sphere externe
//
Sphere(10) = {0, 0, 0, 4, -Pi/2, Pi/2, 2*Pi};
Physical Volume(1) = {10};
//
//	Cube interne
//
Box(20) = {-0.5, -0.5, -0.5, 1, 1, 1};
Physical Volume(2) = {20};
//
// Trou
//
BooleanDifference{ Physical Volume{1}; Delete; }{ Physical Volume{2}; Delete; }