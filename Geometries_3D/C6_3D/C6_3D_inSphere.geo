//
//+
SetFactory("OpenCASCADE");
//
// declaration des deux hexa
Box(20) = {-1, -1, -1, 1, 3, 1};
Physical Volume(1) = {20};
Box(21) = {-1, -1, 0, 3, 1, 1};
Physical Volume(2) = {21};
//
BooleanUnion{ Physical Volume{1}; Delete; }{ Physical Volume{2}; Delete; }
Physical Volume(4) = {1};
//
//
//	Sphere externe (Far field)
//
Sphere(2) = {0, 0, 0, 8, -Pi/2, Pi/2, 2*Pi};
Physical Volume(5) = {2};
BooleanDifference{ Physical Volume{5}; Delete; }{ Physical Volume{4}; Delete; }
//
////////////////////////
//		      //
//	MESH	      //
//		      //
////////////////////////
//+
MeshSize {1:15} = 0.2;
Mesh.MeshSizeMax = 0.5;