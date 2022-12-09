/////////////////////////////////////////
//        Géoétrie simple 2D           //
//    Carre immergé dans Cercle        //
/////////////////////////////////////////
SetFactory("OpenCASCADE");
rayon=2.0;
Circle(1) = {0, 0, 0, rayon, 0, 2*Pi};
//
Line Loop (1) = {1};
//
Plane Surface (1) = {1};
//
// Carré interne
//
Lx=1.0;
//
Point (2) = { -Lx/2.0, -Lx/2.0, 0};
Point (3) = { -Lx/2.0, Lx/2.0, 0};
Point (4) = { Lx/2.0, Lx/2.0, 0};
Point (5) = { Lx/2.0, -Lx/2.0, 0};
// Création des arêtes
Line (2) = {2 ,3}; // gauche
Line (3) = {3 ,4}; // haut
Line (4) = {4 ,5}; // droit
Line (5) = {5 ,2}; // bas
// Définition du contour
Line Loop (2) = { 2, 3, 4, 5};
//
Plane Surface (2) = {2};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }