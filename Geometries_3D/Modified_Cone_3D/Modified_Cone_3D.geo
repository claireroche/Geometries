//+
SetFactory("OpenCASCADE");
//+
coneL = 1.0;
coneR1 = 0.005;
coneR2 = 0.25;
Cone(1) = {0, 0, 0, coneL, 0, 0, coneR2, coneR1, 2*Pi};
coneAngle = Atan(coneR2 / coneL);
//+
Symmetry {1, 0, 0, 1} {
  Volume{1}; Surface{1}; Curve{2}; Curve{3}; 
}
//+
Translate {3, 0, 0} {
  Volume{1}; 
}
//+
Box(2) = {0.75, -0.5, -0.25, 0.5, 0.3, 1.0};
//+
BooleanDifference{ Volume{1}; Delete; }{ Volume{2}; Delete; }
//+
sphereShift = Cos(Pi/2.0+coneAngle)*coneR1;
sphereR = coneR1 / Sin(Pi/2.0+coneAngle);
Sphere(2) = {0.0-sphereShift, 0, 0, sphereR, -Pi/2, Pi/2, 2*Pi};
//+
BooleanUnion{ Volume{1}; Delete; }{ Volume{2}; Delete; }
//+ Along cone length
Transfinite Curve {4} = 180 Using Progression 1;
//+ Along end, small piece
Transfinite Curve {3} = 25 Using Progression 1;
//+ Along end, long piece
Transfinite Curve {1} = 75 Using Progression 1;
//+ Flat bottom, long piece
Transfinite Curve {2} = 100 Using Progression 1;
//+ Flat bottom, short piece
Transfinite Curve {6} = 50 Using Progression 1;
//+ along sphere perimeter
Transfinite Curve {5} = 20 Using Progression 1;
