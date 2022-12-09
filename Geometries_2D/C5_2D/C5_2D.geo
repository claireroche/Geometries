/////////////////////////////////////////
//        Géoétrie simple 2D           //
//    Cercle immergé dans Rectangle    //
/////////////////////////////////////////
SetFactory("OpenCASCADE");
rayon=10.0;
Circle(1) = {0, 0, 0, rayon, 0, 2*Pi};
//
Line Loop (1) = {1};
//
Plane Surface (1) = {1};
//
// Croix interne
Lx=1.0;
//
Point (2) = { Lx, Lx, 0};
Point (3) = { 3.0*Lx, Lx, 0};
Point (4) = { 3.0*Lx, -Lx, 0};
Point (5) = { Lx, -Lx, 0};
Point (6) = { Lx, -3.0*Lx, 0};
Point (7) = { -Lx, -3.0*Lx, 0};
Point (8) = { -Lx, -Lx, 0};
Point (9) = { -3.0*Lx, -Lx, 0};
Point (10) = { -3.0*Lx, Lx, 0};
Point (11) = { -Lx, Lx, 0};
Point (12) = { -Lx, 3.0*Lx, 0};
Point (13) = { Lx, 3.0*Lx, 0};
// Création des arêtes
Line (2) = {2 ,3};
Line (3) = {3 ,4};
Line (4) = {4 ,5};
Line (5) = {5 ,6};
Line (6) = {6 ,7};
Line (7) = {7 ,8};
Line (8) = {8 ,9};
Line (9) = {9 ,10};
Line (10) = {10 ,11};
Line (11) = {11 ,12};
Line (12) = {12 ,13};
Line (13) = {13 ,2};
// Définition du contour
Line Loop (2) = { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
//
Plane Surface (2) = {2};
//
// Trou
//
BooleanDifference{ Surface{1}; Delete; }{ Surface{2}; Delete; }