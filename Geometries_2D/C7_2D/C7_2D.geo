///////////////////////////////////////////
//        Géoétrie simple 2D             //
//Deux demi disques immergés dans Cercle //
///////////////////////////////////////////
SetFactory("OpenCASCADE");
rayon=4.0;
dx=0.3;
Circle(1) = {0, 0, 0, rayon, 0, 2*Pi};
//
Line Loop (1) = {1};
//
Plane Surface (1) = {1};
//
// Demi disque interne gauche
//
Lx=1.0;
//
Point (2) = { -dx, Lx/2.0, 0};
Point (3) = { -dx, -Lx/2.0, 0};
Circle(4) = {-dx, 0, 0, Lx/2.0, Pi/2.0, 3.0*Pi/2.0};
// Création des arêtes
Line (2) = {2 ,3}; 
// Définition du contour
Line Loop (2) = { 2, 4};
//
Plane Surface (2) = {2};
//
// Demi disque interne droit
//
Point (10) = { dx, Lx/2.0, 0};
Point (11) = { dx, -Lx/2.0, 0};
Circle(12) = {dx, 0, 0, Lx/2.0, 3.0*Pi/2.0, Pi/2.0};
// Création des arêtes
Line (13) = {10 ,11}; 
// Définition du contour
Line Loop (14) = { 13, 12};
//
Plane Surface (3) = {14};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }
BooleanDifference{ Surface{1}; Delete; }{ Surface{3}; Delete; }