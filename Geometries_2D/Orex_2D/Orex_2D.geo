Merge "Orex_2D.brep";
SetFactory("OpenCASCADE");
//+
Circle(20) = {700, 0, 0, 3000, 2*Pi};
Line Loop (20) = {20};
Plane Surface (20) = {20};
//
BooleanDifference{ Surface{20}; Delete; }{ Surface{1}; Delete; }