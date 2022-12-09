/////////////////////////////////////////
//        Géoétrie simple 2D           //
//    Cercle immergé dans Ellipse      //
/////////////////////////////////////////
SetFactory("OpenCASCADE");
rayon_x=5.0;
Circle(1) = {3.0, 0, 0, rayon_x, 0, 2*Pi};
//
Line Loop (1) = {1};
//
Plane Surface (1) = {1};
//
// Cercle interne
//
Circle(2) = {0, 0, 0, 0.5, 0, 2*Pi};
// Définition du contour
Line Loop (2) = {2};
//
Plane Surface (2) = {2};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }
