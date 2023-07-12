Merge "Apollo_2D.brep";
SetFactory("OpenCASCADE");
//+
Circle(20) = {50, 0, 0, 150, 2*Pi};
Line Loop (20) = {20};
Plane Surface (20) = {20};
//
BooleanDifference{ Surface{20}; Delete; }{ Surface{1}; Delete; }
