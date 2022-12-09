Merge "RAMCII_2D.brep";
SetFactory("OpenCASCADE");
//+
Ellipse(20) = {1.5, 0, 0, 2.0, 1.5, 0, 2*Pi};
Line Loop (20) = {20};
Plane Surface (20) = {20};
//
BooleanDifference{ Surface{20}; Delete; }{ Surface{1}; Delete; }
//
//
//////////////////////////////////
//		Mesh		//
//////////////////////////////////
//
Transfinite Curve {1,2,3,4} = 60;
Mesh.MeshSizeMax = 0.1;
//
// The default "Frontal-Delauney" (6) leads to the highest mesh quality
// while the "Delaunay" algorithm (5) handles complex mesh sizes.
Mesh.Algorithm = 6 ;