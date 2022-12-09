Merge "Diamond_Airfoil_2D_Papier.brep";
SetFactory("OpenCASCADE");
//+
//////////////////////////////////
//	Boîte englobante	//
//////////////////////////////////
Circle(20) = {200, 0, 0, 250, 2*Pi};
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
Transfinite Curve {1,2,3,4} = 40;
//Transfinite Curve {5} = 600;
Mesh.MeshSizeMax = 50;
//
// The default "Frontal-Delauney" (6) leads to the highest mesh quality
// while the "Delaunay" algorithm (5) handles complex mesh sizes.
Mesh.Algorithm = 6 ;