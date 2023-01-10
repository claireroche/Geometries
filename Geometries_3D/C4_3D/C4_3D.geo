//+
SetFactory("OpenCASCADE");
//
//	Cube interne
//
Box(20) = {-1, -1, -1, 2, 1, 2};
Physical Volume(2) = {20};
Box(21) = {0, 0, 0, -1, 1, -1};
Physical Volume(3) = {21};
//
// Trou
//
BooleanUnion{ Physical Volume{2}; Delete; }{ Physical Volume{3}; Delete; }
Physical Volume(1) = {1};
//
//
//	Sphere externe (Far field)
//
Sphere(10) = {0, 0, 0, 8, -Pi/2, Pi/2, 2*Pi};
Physical Volume(10) = {10};
BooleanDifference{ Physical Volume{10}; Delete; }{ Physical Volume{1}; Delete; }