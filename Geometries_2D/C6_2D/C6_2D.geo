/////////////////////////////////////////
//        Géoétrie simple 2D           //
//  Deux carrés immergés dans Cercle   //
/////////////////////////////////////////
SetFactory("OpenCASCADE");
rayon=4.0;
dx=0.5;
Circle(1) = {0, 0, 0, rayon, 0, 2*Pi};
//
Line Loop (1) = {1};
//
Plane Surface (1) = {1};
//
// Carré interne gauche
//
Lx=1.0;
//
Point (2) = { -dx -Lx, -Lx/2.0, 0};
Point (3) = { -dx -Lx, Lx/2.0, 0};
Point (4) = { -dx, Lx/2.0, 0};
Point (5) = { -dx, -Lx/2.0, 0};
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
// Carré interne droit
//
Point (6) = { dx, -Lx/2.0, 0};
Point (7) = { dx, Lx/2.0, 0};
Point (8) = { dx+Lx, Lx/2.0, 0};
Point (9) = { dx+Lx, -Lx/2.0, 0};
// Création des arêtes
Line (6) = {6 ,7}; // gauche
Line (7) = {7 ,8}; // haut
Line (8) = {8 ,9}; // droit
Line (9) = {9 ,6}; // bas
// Définition du contour
Line Loop (3) = { 6, 7, 8, 9};
//
Plane Surface (3) = {3};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }
BooleanDifference{ Surface{1}; Delete; }{ Surface{3}; Delete; }