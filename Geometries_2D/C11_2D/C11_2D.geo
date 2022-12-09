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

Point(7) = {0.764456,-0.049530,0,ls};  // End of flare
Point(8) = {0.525670,-0.034925,0,ls};  // Cyl Flare junction
Point(9) = {0.398147,-0.034925,0,ls};  // Cone Cyl junction
Point(10) = {R+(Cos(Pi/2+5*Pi/180)*R),-Sin(Pi/2+5*Pi/180)*R,0,ls};

Circle(1) = {1, 6, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
Line(4) = {4, 5};

Circle(5) = {10,6,1};
Line(6) = {10,9};
Line(7) = {9,8};
Line(8) = {8,7};
Line(9) = {7,5};

Line Loop (1) = {1,2,3,4,9,8,7,6,5};

Plane Surface (1) = {1};

rayon_x=1.2;
rayon_y=0.2;
Ellipse(100) = {1.0, 0, 0, rayon_x, rayon_y, 0, 2*Pi};
//
Line Loop (2) = {100};
//
Plane Surface (2) = {2};

BooleanDifference{ Surface{2}; Delete; }{ Surface{1}; Delete; }

SetFactory("OpenCASCADE");
