Merge "Scramspace_XOZ_2D.brep";
SetFactory("OpenCASCADE");
//+
Circle(20) = {150, 0, 0, 200, 2*Pi};
Line Loop (20) = {20};
Plane Surface (20) = {20};
//
BooleanDifference{ Surface{20}; Delete; }{ Surface{1}; Delete; }