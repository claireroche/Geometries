// Gmsh project created on Fri Feb 26 07:14:39 2021
SetFactory("OpenCASCADE");
ls = 1.0;
m1 = 0.2;
m = 0.1;  
R = 0.0001;

Point(1) = {0,0,0,ls};
//Point(2) = {0.000092,0.0000997,0,ls}; // Nose cone junction
Point(2) = {R+(Cos(Pi/2+5*Pi/180)*R),Sin(Pi/2+5*Pi/180)*R,0,ls};
Point(3) = {0.398147,0.034925,0,ls};  // Cone Cyl junction
Point(4) = {0.525670,0.034925,0,ls};  // Cyl Flare junction
Point(5) = {0.764456,0.049530,0,ls};  // End of flare
Point(6) = {R, 0, 0, ls};	    // center of nose

Point(8) = {m*(0-R)/R, 0, 0, ls};
Point(9) = {R+(Cos(Pi/2+5*Pi/180)*R)+m*(R+(Cos(Pi/2+5*Pi/180)*R)-R)/R,Sin(Pi/2+5*Pi/180)*R + m*(Sin(Pi/2+5*Pi/180)*R-0)/R, 0,ls}; // Nose cone junction
Point(10) = {0.398147,0.034925+m,0,ls};  // Cone Cyl junction
Point(11) = {0.525670,0.034925+m,0,ls};  // Cyl Flare junction
Point(12) = {0.764456,0.049530+m,0,ls};  // End of flare


Circle(1) = {1, 6, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
Line(4) = {4, 5};
Line(5) = {5, 12}; 
Line(6) = {12, 11}; 
Line(7) = {11, 10}; 
Line(8) = {10, 9}; 
Circle(9) = {8, 6, 9}; 
Line(10) = {8, 1}; 
Line(11) = {2, 9}; 
Line(12) = {3, 10};
Line(13) = {4, 11};
Line(14) = {5, 12};  
//+
Curve Loop(1) = {6, -13, 4, 5};
Surface(1) = {1};
Curve Loop(3) = {7, -12, 3, 13};
Surface(2) = {3};
Curve Loop(5) = {8, -11, 2, 12};
Surface(3) = {5};
Curve Loop(7) = {9, -11, -1, -10};
Surface(4) = {7};

//+
Rotate {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Surface{4}; Curve{9}; Curve{11}; Point{9}; Curve{10}; Point{8}; Point{1}; Curve{1}; Point{6}; Point{2}; Curve{2}; Curve{8}; Surface{3}; Point{10}; Curve{12}; Point{3}; Curve{6}; Surface{2}; Curve{13}; Curve{7}; Point{11}; Curve{3}; Point{4}; Surface{1}; Curve{4}; Point{5}; Curve{5}; Point{12}; Curve{14};
}
//+ thickness
F1 = 500;
F2 = 500;
F3 = 500;
F4 = 500;
F5 = 500;
Transfinite Curve {24, 20, 19, 17, 15} = 0.05*F1 Using Progression 1;
//+ flare
Transfinite Curve {6, 23} = 0.2*F2 Using Progression 1;
//+ cylinder
Transfinite Curve {22, 21} = 0.2*F3 Using Progression 1;
//+ cone
Transfinite Curve {8, 2} = 0.4*F4 Using Progression 1;
//+ nose
Transfinite Curve {18, 16} = 0.1*F5 Using Progression 1;

//+
Transfinite Surface {1};
//+
Transfinite Surface {2};
//+
Transfinite Surface {3};
//+
Transfinite Surface {4};
//+
Recombine Surface {4, 3, 2, 1};
//+

Delete {
  Curve{14}; 
}

//+
Extrude {{1, 0, 0}, {0, 0, 0}, Pi} {
  Curve{15}; Curve{18}; Curve{17}; Curve{16}; Surface{4}; Curve{2}; Curve{8}; Surface{3}; Surface{2}; Curve{19}; Curve{22}; Curve{21}; Curve{20}; Surface{1}; Curve{23}; Curve{24}; Curve{6}; Layers{5}; Recombine;
}
//+
Physical Surface("symmetry") = {12, 3, 16, 20, 1, 2, 8, 4};
//+
Physical Surface("outflow") = {19, 9, 15, 17};
//+
Physical Surface("freestream") = {7};
//+
Physical Surface("wall") = {10, 14, 18, 5};
//+
Physical Volume("fluid") = {1, 2, 3, 4};
//+
SetFactory("OpenCASCADE");
