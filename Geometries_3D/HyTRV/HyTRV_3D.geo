Merge "HyTRV_model.brep";
SetFactory("OpenCASCADE");
//+
Surface Loop (1) = {1,2,3,4};
Volume (1) = {1};
//
Sphere(2) = {600, 0, 76, 2000, -Pi/2, Pi/2, 2*Pi};
//
BooleanDifference{ Volume{2}; Delete; }{ Volume{1}; Delete; }
