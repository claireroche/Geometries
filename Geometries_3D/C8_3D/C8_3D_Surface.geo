//
// nombre de noeuds par direction
x1=4;
x2=4;
x3=4;
y1=4;
y2=4;
z1=4;
z2=4;
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
//
Volume (1) = {1} ;
Physical Volume (1) = {1};
Box(2) = {-2, -1, -1, 4, 2, -2};
Physical Volume(2) = {2};
//
// On ajoute des points supplémentaires
//
Point(17) = {-2,0,-1};
Point(18) = {0,1,-1};
Point(19) = {2,0,-1};
Point(20) = {0,-1,-1};
//
Point(21) = {-1,1,-1};
Point(22) = {1,1,-1};
Point(23) = {-1,-1,-1};
Point(24) = {1,-1,-1};
//
Line(25) = {17,5};
Line(26) = {18,6};
Line(27) = {19,7};
Line(28) = {20,8};
Line(29) = {21,5};
Line(30) = {22,7};
Line(31) = {24,7};
Line(32) = {23,5};
//
Line(33) = {11,17};
Line(34) = {17,9};
Line(35) = {15,19};
Line(36) = {13,19};
Line(37) = {11,21};
Line(38) = {18,21};
Line(39) = {18,22};
Line(40) = {15,22};
Line(41) = {9,23};
Line(42) = {20,23};
Line(43) = {20,24};
Line(44) = {13,24};
//
Line Loop(60) = {25,29,37,33};
Line Loop(61) = {29,5,26,38};
Line Loop(62) = {6,30,39,26};
Line Loop(63) = {30,40,35,27};
Line Loop(64) = {31,44,36,27};
Line Loop(65) = {31,7,28,43};
Line Loop(66) = {42,32,8,28};
Line Loop(67) = {32,25,34,41};
Plane Surface(60) = {60};
Plane Surface(61) = {61};
Plane Surface(62) = {62};
Plane Surface(63) = {63};
Plane Surface(64) = {64};
Plane Surface(65) = {65};
Plane Surface(66) = {66};
Plane Surface(67) = {67};
//
// on fragmente le tout pour avoir une geometrie coherente
BooleanFragments{ Volume{1}; Volume{2}; Delete; }{ Surface{60:67}; Surface{2}; Surface{12}; Curve{14}; Curve{24}; Curve{18}; Curve{22}; Curve{33:44}; Delete; }
//
// on met toutes les surfaces dans un groupe physique
Physical Surface(1) = {1,3:6,60:72};
//
//
////////////////////////
//		      //
//	MESH	      //
//		      //
////////////////////////
//+
//+
// definition du maillage sur les courbes
// direction x
Transfinite Curve {37,25,41} = x1 Using Progression 1;
Transfinite Curve {38,39,42,43,5,1,4,8,6,2,3,7} = x2 Using Progression 1;
Transfinite Curve {27,40,44} = x3 Using Progression 1;
Transfinite Curve {51,52} = x1+x2+x2+x3-3 Using Progression 1;
//+
// direction y
Transfinite Curve {33,29,26,30,35} = y1 Using Progression 1;
Transfinite Curve {34,32,28,31,36} = y2 Using Progression 1;
Transfinite Curve {47,50} = y1+y2-1 Using Progression 1;
//+
// direction z
Transfinite Curve {9,10,11,12} = z1 Using Progression 1;
Transfinite Curve {45,46,49,48} = z2 Using Progression 1;
//
// on declare les surfaces en transfinies pour avoir un maillage regle
// certaines surfaces ont 5 points : il faut definir les coins
//
Transfinite Surface {1:6,60:72};
Transfinite Surface {71} = {11,26,28,15};
Transfinite Surface {70} = {9,25,27,13};
Transfinite Surface {68} = {11,26,25,9};
Transfinite Surface {69} = {15,28,27,13};
//
// on recombine les surfaces pour avoir des quads
Recombine Surface "*";
//+
