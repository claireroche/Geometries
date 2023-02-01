//+
SetFactory("OpenCASCADE");
Sphere(1) = {0, 0, 0, 2, -Pi/2, Pi/2, 2*Pi};
//
Sphere(2) = {0, 0, 0, 0.5, -Pi/2, Pi/2, 2*Pi};
//
// Trou
//
BooleanDifference{ Volume{1}; Delete; }{ Volume{2}; Delete; }