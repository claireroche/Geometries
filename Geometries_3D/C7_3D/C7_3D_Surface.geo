//
// nombre de noeuds par direction
x1=4;
x2=4;
x3=4;
//
//+
SetFactory("OpenCASCADE");
//
// declaration des deux hexa
Point(1) = {-1,0,1};
Point(2) = {0,0.15,1};
Point(3) = {1,0,1};
Point(4) = {0,-0.15,1};
Point(5) = {-1,0,-1};
Point(6) = {0,0.15,-1};
Point(7) = {1,0,-1};
Point(8) = {0,-0.15,-1};
//
Line (1) = {1,2};
Line (2) = {2,3};
Line (3) = {3,4};
Line (4) = {4,1};
Line Loop (1) = {1:4};
Line (5) = {5,6};
Line (6) = {6,7};
Line (7) = {7,8};
Line (8) = {8,5};
Line Loop (2) = {5:8};
Line (9) = {1,5};
Line (10) = {2,6};
Line (11) = {3,7};
Line (12) = {4,8};
Line Loop (3) = {1,10,5,9};
Line Loop (4) = {2,11,6,10};
Line Loop (5) = {3,11,7,12};
Line Loop (6) = {4,12,8,9};
//
Plane Surface (1) = {1};
Plane Surface (2) = {2};
Plane Surface (3) = {3};
Plane Surface (4) = {4};
Plane Surface (5) = {5};
Plane Surface (6) = {6};
Surface Loop (1) = {1:6};
Physical Surface(1) = {1:6};
//
////////////////////////
//		      //
//	MESH	      //
//		      //
////////////////////////
//+
//
// definition du maillage sur les courbes
// 
Transfinite Curve {1,3,7,5} = x1 Using Progression 1;
Transfinite Curve {2,4,8,6} = x2 Using Progression 1;
Transfinite Curve {9,10,11,12} = x3 Using Progression 1;
//
Transfinite Surface {1:6};
// on recombine les surfaces pour avoir des quads
Recombine Surface "*";
//+
