//
// nombre de noeuds par direction
x1=4;
x2=4;
y1=4;
y2=4;
z1=4;
z2=4;
//+
SetFactory("OpenCASCADE");
//
// declaration des quatres cubes
Box(20) = {-1, -1, -1, 2, 1, 1};
Physical Volume(1) = {20};
Box(21) = {-1, 0, -1, 1, 1, 1};
Physical Volume(2) = {21};
Box(22) = {-1, -1, 0, 1, 1, 1};
Physical Volume(3) = {22};
//
BooleanUnion{ Physical Volume{1}; Delete; }{ Physical Volume{2}; Delete; }
Physical Volume(4) = {23};
BooleanUnion{ Physical Volume{4}; Delete; }{ Physical Volume{3}; Delete; }
Physical Volume(5) = {1};
//
//
//	Sphere externe (Far field)
//
Sphere(2) = {0, 0, 0, 8, -Pi/2, Pi/2, 2*Pi};
Physical Volume(6) = {2};
BooleanDifference{ Physical Volume{6}; Delete; }{ Physical Volume{5}; Delete; }
//
////////////////////////
//		      //
//	MESH	      //
//		      //
////////////////////////
//+
MeshSize {1:17} = 0.2;
Mesh.MeshSizeMax = 0.5;