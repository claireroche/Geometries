def CercleAngle(xcentre,ycentre,zcentre,rayon,angle,size):
    """Construction d'un arc de cercle à partir d'un centre donnée et d'un rayon donné
    on s'arrete à un angle donné"""
    #Construction du centre du cercle
    pcentre=gmsh.model.occ.addPoint(x=xcentre,y=ycentre,z=zcentre,meshSize=size,tag=-1)
    # Construction du premier point de l'arc
    pdeb = gmsh.model.occ.addPoint(x=xcentre-rayon,y=ycentre,z=zcentre,meshSize=size,tag=-1)
    # Construction du deuxieme point de l'arc
    angle=np.radians(angle+90.)
    xfin = xcentre + rayon*math.cos(angle)
    yfin = ycentre + rayon*math.sin(angle)
    zfin = zcentre
    pfin = gmsh.model.occ.addPoint(x=xfin,y=yfin,z=zfin,meshSize=size,tag=-1)
    # Construction de l'arc
    arc = gmsh.model.occ.addCircleArc(startTag=pdeb,centerTag=pcentre,endTag=pfin,tag=-1)
    return pcentre,pdeb,pfin,arc

def DroiteAngle(pdeb,angle,xdroite):
    """Construction d'une droite à partir d'un point à un angle donné et jusqu'à une abscisse donnée"""
    gmsh.model.occ.synchronize()
    alpha=np.radians(angle)
    xarc,_,_,_,_,_=gmsh.model.getBoundingBox(dim=0,tag=pdeb)
    x=xdroite-xarc
    y=x*math.tan(alpha)
    copie = gmsh.model.occ.copy(dimTags=[(0,pdeb)])
    gmsh.model.occ.translate(dimTags=copie,dx=x,dy=y,dz=0.)
    pfin=copie[0][1]
    ligne=gmsh.model.occ.addLine(startTag=pdeb,endTag=pfin,tag=-1)
    return pfin,ligne

def Ortho(angle1,angle2,pfin,pdeb):
    """Cette fonction calcule l'abscisse du point d'intersection entre la perpendiculaire à la droite paroi et la droite amont"""
    gmsh.model.occ.synchronize()
    tan1=math.tan(np.radians(angle1))
    tan2=math.tan(np.radians(angle2))
    #On recupere les coordonnes de la fin de la droite paroi
    xfin,yfin,_,_,_,_= gmsh.model.getBoundingBox(dim=0,tag=pfin)
    # On recupere les coordonnees du debut de la droite amont
    xdeb,ydeb,_,_,_,_= gmsh.model.getBoundingBox(dim=0,tag=pdeb)
    numerateur=(xfin/tan1)+yfin+tan2*xdeb-ydeb
    denominateur=(tan2+1./tan1)
    #xdroite[2]=numerateur/denominateur
    return numerateur/denominateur

import sys
# emplacement du fichier gmsh.py : a renseigner
sys.path.insert(0,"/Logiciels/GMSH/gmsh-git-Linux64-sdk/lib")
#
import math
import numpy as np
import gmsh
import argparse

# definition des argumenents de lancement du script
parser = argparse.ArgumentParser()
parser.add_argument("-rint",help="Rayon du conesphere parai",type=float,default=0.02)
parser.add_argument("-rext",help="Rayon du conesphere amont",type=float,default=0.05)
parser.add_argument("-xamont",help="Abscisse du centre du cercle amont",type=float,default=0.04)
parser.add_argument("-aint",help="Angle corps",type=float,default=9.)
parser.add_argument("-aamont",help="Angle amont",type=float,default=20.)
parser.add_argument("-mparoi",help="Taille du maillage au niveau de la paroi",type=float,default=0.01)
parser.add_argument("-mamont",help="Taille du maillage au niveau de la frontiere amont",type=float,default=0.01)
parser.add_argument("-xfin",help="Abscisse de la fin de la paroi",type=float,default=0.15)
args = parser.parse_args()

gmsh.initialize()

gmsh.model.add("conesphere")
#
gmsh.option.setNumber("General.Terminal",1)
gmsh.option.setNumber("Mesh.MshFileVersion",2.2)
#
# Construction de l'arc de cercle de la paroi
p_centre_paroi,pdeb_arc_paroi,pfin_arc_paroi,arc_paroi=CercleAngle(xcentre=args.rint,ycentre=0.,zcentre=0.,rayon=args.rint,angle=args.aint,size=args.mparoi)

# Construction de l'arc de cercle amont
p_centre_amont,pdeb_arc_amont,pfin_arc_amont,arc_amont=CercleAngle(xcentre=args.xamont,ycentre=0.,zcentre=0.,rayon=args.rext,angle=args.aamont,size=args.mamont)

# Construction de la droite tangente à l'arc allant jusqu'à l'absisse indiqué par l'utilisateur
p_fin_paroi,droite_paroi=DroiteAngle(pdeb=pfin_arc_paroi,angle=args.aint,xdroite=args.xfin)
#
x_fin_amont = Ortho(angle1=args.aint,angle2=args.aamont,pfin=p_fin_paroi,pdeb=pfin_arc_amont)
#
p_fin_amont,droite_amont=DroiteAngle(pdeb=pfin_arc_amont,angle=args.aamont,xdroite=x_fin_amont)
#
# construction de l'axe
l_axe = gmsh.model.occ.addLine(startTag=pdeb_arc_amont,endTag=pdeb_arc_paroi,tag=-1)
#
# construction de la ligne de fin
l_bord = gmsh.model.occ.addLine(startTag=p_fin_paroi,endTag=p_fin_amont,tag=-1)
#
#wire=gmsh.model.occ.addWire(curveTags=[l_axe,arc_paroi,droite_paroi,l_bord,droite_amont,arc_amont],tag=-1)
wire=gmsh.model.occ.addWire(curveTags=[arc_amont,droite_amont,l_bord,droite_paroi,arc_paroi,l_axe],tag=-1)

# creation de la surface plane
gmsh.model.occ.addPlaneSurface(wireTags=[wire],tag=-1)
#
#
# synchronisation : ne jamais oublier cette operation !
gmsh.model.occ.synchronize()
#
# creation des groupes physiques fluide et paroi
tag_paroi=gmsh.model.addPhysicalGroup(dim=1,tags=[arc_paroi,droite_paroi])
tag_fluide=gmsh.model.addPhysicalGroup(dim=2,tags=[1])
#
# realisation du maillage
gmsh.model.mesh.generate(dim=2)
# inversion des normales des triangles (uniquement version gmsh.4.9.3)
#gmsh.model.mesh.reverse(dimTags=[(2,1)])
#
fichier = open("paroi.txt", "w")
#
# ecriture des noeuds de la frontiere paroi
for node in gmsh.model.mesh.getNodesForPhysicalGroup(dim=1,tag=tag_paroi)[0]:
    fichier.write(str(node)+" "+str(gmsh.model.mesh.getNode(nodeTag=node)[0][0])+" "
    +str(gmsh.model.mesh.getNode(nodeTag=node)[0][1])+" "
    +str(gmsh.model.mesh.getNode(nodeTag=node)[0][2])+"\n")

# fichier a ecrire dans le format choisi (vtk,mesh,msh2,msh4,...)
gmsh.write(fileName="lulu.vtk")

gmsh.fltk.run()

gmsh.finalize()

fichier.close()
