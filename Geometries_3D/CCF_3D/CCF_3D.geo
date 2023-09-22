// Gmsh project created on Fri Feb 26 07:14:39 2021
SetFactory("OpenCASCADE");
R = 0.0001;

Point(1) = {0,0,0};
Point(2) = {R+(Cos(Pi/2+5*Pi/180)*R),Sin(Pi/2+5*Pi/180)*R,0};
Point(3) = {0.398147,0.034925,0};  // Cone Cyl junction
Point(4) = {0.525670,0.034925,0};  // Cyl Flare junction
Point(5) = {0.764456,0.049530,0};  // End of flare
Point(6) = {R, 0, 0};	    // center of nose
Point(7) = {0.764456,0,0};

Circle(1) = {1, 6, 2}; 
Line(2) = {2, 3}; 
Line(3) = {3, 4}; 
Line(4) = {4, 5};
Line(5) = {5, 7};
Line(6) = {7, 1};
//
Curve Loop(1) = {1, 2, 3, 4, 5, 6};
Surface(1) = {1};
//
//+
Extrude {{1, 0, 0}, {0, 0, 0}, 2*Pi} {
  Surface{1};
}
Delete {Surface{1}; }
