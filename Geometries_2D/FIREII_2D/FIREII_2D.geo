Merge "FIREII_2D.brep";
SetFactory("OpenCASCADE");
//+
Ellipse(20) = {0.5, 0, 0, 1.0, 1.0, 0, 2*Pi};
Line Loop (20) = {20};
Plane Surface (20) = {20};
//
BooleanDifference{ Surface{20}; Delete; }{ Surface{1}; Delete; }