//+
SetFactory("OpenCASCADE");
Sphere(1) = {0, 0, 0, 2, -Pi/2, Pi/2, 2*Pi};
Volume (1) = {1};
//
Sphere(2) = {0, 0, 0, 0.5, -Pi/2, Pi/2, 2*Pi};
Volume (2) = {2};
//
// Trou
//
BooleanDifference{ Volume{1}; Delete; }{ Volume{2}; Delete; }