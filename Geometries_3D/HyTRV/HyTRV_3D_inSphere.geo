Merge "HyTRV_3D.brep";
SetFactory("OpenCASCADE");
//+
Surface Loop (1) = {1,2,3,4};
Volume (1) = {1};
//
Sphere(2) = {1000, 0, 76, 2000, -Pi/2, Pi/2, 2*Pi};
Dilate {{500, 0, 0}, {1, 0.5, 0.5}} { Volume{2}; }
//
BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; }
