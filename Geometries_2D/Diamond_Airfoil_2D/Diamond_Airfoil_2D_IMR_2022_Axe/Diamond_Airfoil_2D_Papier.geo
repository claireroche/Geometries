Merge "Diamond_Airfoil_2D_Papier.brep";
SetFactory("OpenCASCADE");
//+
//////////////////////////////////
//	Boîte englobante	//
//////////////////////////////////
Circle(20) = {200, 0, 0, 250, Pi};
Line(21) = {5,2};
Line(22) = {3,6};
Line Loop (100) = {20,21,4,3,22};
Plane Surface (100) = {100};

Circle(30) = {200, 0, 0, 250, Pi, 2*Pi};
Line Loop (105) = {30,21,1,2,22};
Plane Surface (105) = {105};
//
BooleanDifference{ Surface{100}; Delete; }{ Surface{1}; Delete; }
//
//

//////////////////////////////////
//		Mesh		//
//////////////////////////////////
//
Transfinite Curve {1,2,3,4} = 1000;
//Transfinite Curve {5} = 600;
Mesh.MeshSizeMax = 10;
//
// The default "Frontal-Delauney" (6) leads to the highest mesh quality
// while the "Delaunay" algorithm (5) handles complex mesh sizes.
Mesh.Algorithm = 6 ;
