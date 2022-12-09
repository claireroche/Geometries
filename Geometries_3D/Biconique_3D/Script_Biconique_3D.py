import sys
import math
import gmsh
import argparse

# definition des argumenents de lancement du script
parser = argparse.ArgumentParser()
parser.add_argument("-L",help="",type=float,default=1000.)
parser.add_argument("-H",help="",type=float,default=300.)
parser.add_argument("-R1",help="",type=float,default=50.)
parser.add_argument("-R2",help="",type=float,default=150.)
parser.add_argument("-Rr",help="",type=float,default=1000.)
parser.add_argument("-x0",help="",type=float,default=0.)
parser.add_argument("-g","--geom",help="Ecriture de la geometrie",action="store_false")
parser.add_argument("-i","--ihm",help="Lancement de l'IHM de GMSH a la fin du traitement",action="store_false")
parser.add_argument("-tparoi",help="",type=float,default=20.)
parser.add_argument("-tamont",help="",type=float,default=250.)
args = parser.parse_args()
#
gmsh.initialize()
gmsh.model.add("biconique-interieur")
#
gmsh.option.setNumber("General.Terminal",1)
gmsh.option.setNumber("Mesh.MshFileVersion",2.2)
#
# parametres
x0=args.x0
L=args.L
H=args.H
R1=args.R1
R2=args.R2
Rr=args.Rr
th1=25.*math.pi/180.
th2=10.*math.pi/180.
tparoi=args.tparoi
tamont=args.tamont
#
# calculs intermediaires
alpha=(math.sin(th2)*(L-R1-R2) - math.cos(th2)*(H-R2) + R1*math.cos(th1-th2) - R2)/math.sin(th1-th2)
xm = L-R1*(1-math.sin(th1)) + alpha*math.cos(th1)
ym = R1*math.cos(th1) - alpha*math.sin(th1)
xc = xm + Rr/math.cos((th1-th2)/2)*math.cos(math.pi/2+(th1+th2)/2)
yc = ym - Rr/math.cos((th1-th2)/2)*math.sin(math.pi/2+(th1+th2)/2)
#
# creation des points (centre des cercles)
pc1=gmsh.model.occ.addPoint(x=0.,y=0.,z=-x0+L-R1,meshSize=0.)
pc2=gmsh.model.occ.addPoint(x=H-R2,y=0.,z=-x0+R2,meshSize=0.)
pcr=gmsh.model.occ.addPoint(x=yc,y=0.,z=xc,meshSize=0.)
#
# creation des autres points
p1 = gmsh.model.occ.addPoint(x=0., y=0., z=-x0+L, meshSize=0.)
p2 = gmsh.model.occ.addPoint(x=R1*math.cos(th1), y=0., z=-x0+L-R1*(1-math.sin(th1)), meshSize=tparoi)
p3 = gmsh.model.occ.addPoint(x=yc+Rr*math.sin(math.pi/2+th1), y=0, z=-x0+xc-Rr*math.cos(math.pi/2+th1), meshSize=tparoi)
p4 = gmsh.model.occ.addPoint(x=yc+Rr*math.sin(math.pi/2+th2), y=0, z=-x0+xc-Rr*math.cos(math.pi/2+th2), meshSize=tparoi)
p5 = gmsh.model.occ.addPoint(x=H-R2*(1-math.cos(th2)), y=0, z=-x0+R2*(1+math.sin(th2)), meshSize=tparoi)
p6 = gmsh.model.occ.addPoint(x=H-R2, y=0, z=-x0, meshSize=tparoi)
p7 = gmsh.model.occ.addPoint(x=0, y=0, z=-x0, meshSize=tparoi)
#
# definition des courbes
l1 = gmsh.model.occ.addCircleArc(startTag=p1,centerTag=pc1,endTag=p2,tag=-1)
l2 = gmsh.model.occ.addLine(startTag=p2,endTag=p3,tag=-1)
l3 = gmsh.model.occ.addCircleArc(startTag=p3,centerTag=pcr,endTag=p4,tag=-1)
l4 = gmsh.model.occ.addLine(startTag=p4,endTag=p5,tag=-1)
l5 = gmsh.model.occ.addCircleArc(startTag=p5,centerTag=pc2,endTag=p6,tag=-1)
l6 = gmsh.model.occ.addLine(startTag=p6,endTag=p7,tag=-1)
#
# on stocke toutes les lignes dans une liste
all_lines=[(1,l1),(1,l2),(1,l3),(1,l4),(1,l5),(1,l6)]
#
# revolution des lignes de 360 degres selon Oz
revolve=gmsh.model.occ.revolve(dimTags=all_lines,x=0.,y=0.,z=0.,ax=0.,ay=0.,az=1.,angle=2.*math.pi)
#
# creation de la sphere exterieure
vol=gmsh.model.occ.addSphere(xc=0.,yc=0.,zc=L/2,radius=L,tag=-1)

# mise en coherence du modele
gmsh.model.occ.fragment(objectDimTags=[(3,vol)],toolDimTags=revolve,tag=-1,removeTool=True,removeObject=True)
#
# destruction du volume interieur
gmsh.model.occ.remove(dimTags=[(3,2)],recursive=True)

# synchronisation : ne jamais oublier cette operation !
gmsh.model.occ.synchronize()
#
fluide = gmsh.model.addPhysicalGroup(dim=3,tags=[1])
gmsh.model.setPhysicalName(dim=3,tag=fluide,name="FLUIDE")
#
# definition du maillage sur la sphere
points = gmsh.model.getBoundary(dimTags=[(2,7)],combined=True,recursive=True)
gmsh.model.mesh.setSize(dimTags=points,size=tamont)
#
# generation du maillage en 3d
gmsh.model.mesh.generate(dim=3)
#
# appel de l'IHM
if args.ihm == True:
    gmsh.fltk.run()
#
# ecriture du fichier maillage en vtk
gmsh.write(fileName="biconique.vtk")
#
gmsh.finalize()