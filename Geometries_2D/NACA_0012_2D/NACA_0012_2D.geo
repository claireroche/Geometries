Merge "NACA_0012_2D.brep";
SetFactory("OpenCASCADE");
//+
//////////////////////////////////
//	Boîte englobante	//
//////////////////////////////////
Circle(20) = {2.5, 0, 0, 3.0, 2*Pi};
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
Transfinite Curve {1,2} = 100;
Mesh.MeshSizeMax = 0.3;
//
// The default "Frontal-Delauney" (6) leads to the highest mesh quality
// while the "Delaunay" algorithm (5) handles complex mesh sizes.
Mesh.Algorithm = 6 ;
