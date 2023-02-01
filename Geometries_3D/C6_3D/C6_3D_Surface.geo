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
// declaration des deux hexa
Box(20) = {-1, -1, -1, 1, 3, 1};
Box(21) = {-1, -1, 0, 3, 1, 1};
//
// on fragmente le tout pour avoir une geometrie coherente
BooleanFragments{ Volume{20}; Volume{21}; Delete; }{ Curve{1}; Curve{5}; Curve{10}; Curve{19}; Delete; }
//+
// on met toutes les surfaces dans un groupe physique
Physical Surface(1) = {1:5,7:13};
//
////////////////////////
//		      //
//	MESH	      //
//		      //
////////////////////////
//+
//
//+
// definition du maillage sur les courbes
// direction x
Transfinite Curve {20,10,23,22,21} = x1 Using Progression 1;
Transfinite Curve {31,33} = x2 Using Progression 1;
Transfinite Curve {32,34} = x1+x2-1 Using Progression 1;
//+
// direction y
Transfinite Curve {11, 25, 28, 30, 16} = y1 Using Progression 1;
Transfinite Curve {12,17} = y2 Using Progression 1;
Transfinite Curve {14,19} = y1+y2-1 Using Progression 1;
//+
// direction z
Transfinite Curve {24, 26, 29, 27} = z1 Using Progression 1;
Transfinite Curve {1, 15,18,13} = z2 Using Progression 1;
//
// on declare les surfaces en transfinies pour avoir un maillage regle
// certaines surfaces ont 5 points : il faut definir les coins
//
Transfinite Surface {3:9,12:13};
Transfinite Surface {10} = {11,1,14,13};
Transfinite Surface {11} = {16,15,12,2};
Transfinite Surface {1} = {5,1,3,4};
Transfinite Surface {2} = {6,7,10,9};
//
// on recombine les surfaces pour avoir des quads
Recombine Surface "*";
//+
