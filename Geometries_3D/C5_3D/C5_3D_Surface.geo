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
Box(21) = {-1, 0, -1, 1, 1, 1};
Box(22) = {-1, -1, 0, 1, 1, 1};
//
// ajout de points supplementaires
Point(25) = {0,-1,-1};
// ajout de droites supplementaires
Line(37) = {25, 22};
Line(38) = {25, 14};
// on fragmente le tout pour avoir une geometrie coherente
BooleanFragments{ Volume{20}; Volume{21}; Volume{22}; Delete; }{ Curve{22}; Curve{13}; Delete; }
//+
// on met toutes les surfaces dans un groupe physique
Physical Surface(1) = {1:3,5:6,8:18};
//
////////////////////////
//		      //
//	MESH	      //
//		      //
////////////////////////
//+
//
// definition du maillage sur les courbes
// direction x
Transfinite Curve {60, 61, 22, 69, 68, 47, 49 } = x1 Using Progression 1;
Transfinite Curve {51, 52, 48} = x2 Using Progression 1;
Transfinite Curve {46} = x1+x2-1 Using Progression 1;
//+
// direction y
Transfinite Curve {41, 40, 63, 66, 53, 43, 45, 38} = y1 Using Progression 1;
Transfinite Curve {54, 57, 59, 56} = y2 Using Progression 1;
//+
// direction z
Transfinite Curve {39, 13, 55, 58, 50, 44, 42, 37} = z1 Using Progression 1;
Transfinite Curve {62, 64, 67, 65} = z2 Using Progression 1;
//
// on declare les surfaces en transfinies pour avoir un maillage regle
//
Transfinite Surface {1:18};
Transfinite Surface {6} = {29,33,31,26};
Transfinite Surface {3} = {26,31,30,27};
//
// on recombine les surfaces pour avoir des quads
Recombine Surface "*";
//+
