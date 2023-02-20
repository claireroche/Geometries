from salome.shaper import model
import sys, os

model.begin()
partSet = model.moduleDocument()

### Create Part
Part_1 = model.addPart(partSet)
Part_1_doc = Part_1.document()

### Create Sphere
Sphere_1 = model.addSphere(Part_1_doc, model.selection("VERTEX", "PartSet/Origin"), 1)

### Create Sphere
Sphere_2 = model.addSphere(Part_1_doc, model.selection("VERTEX", "PartSet/Origin"), 1)

### Create Scale
Scale_1 = model.addScale(Part_1_doc, [model.selection("COMPOUND", "all-in-Sphere_1")] , model.selection("VERTEX", "PartSet/Origin"), 0.06 , 0.015, 0.025, keepSubResults = True)

### Create Scale
Scale_2 = model.addScale(Part_1_doc, [model.selection("SOLID", "Sphere_2_1")] , model.selection("VERTEX", "PartSet/Origin"), 0.035 , 0.025, 0.0175, keepSubResults = True)

### Create Split
Split_1 = model.addSplit(Part_1_doc, [model.selection("SOLID", "Scale_2_1")], [model.selection("COMPOUND", "Scale_1_1")], keepSubResults = True)

### Create Recover
Recover_1 = model.addRecover(Part_1_doc, Split_1, [Scale_1.result()])

### Create Remove_SubShapes
Remove_SubShapes_1 = model.addRemoveSubShapes(Part_1_doc, model.selection("COMPSOLID", "Split_1_1"))
Remove_SubShapes_1.setSubShapesToKeep([model.selection("SOLID", "Split_1_1_3")])

### Create Fuse
Fuse_1 = model.addFuse(Part_1_doc, [model.selection("COMPOUND", "Recover_1_1"), model.selection("SOLID", "Remove_SubShapes_1_1")], keepSubResults = True)

### Create Point
Point_2 = model.addPoint(Part_1_doc, -1, -1, -1)

### Create Point
Point_3 = model.addPoint(Part_1_doc, 0, 1, 1)

### Create Box
Box_1 = model.addBox(Part_1_doc, model.selection("VERTEX", "Point_1"), model.selection("VERTEX", "Point_2"))

### Create Cut
Cut_1 = model.addCut(Part_1_doc, [model.selection("SOLID", "Fuse_1_1")], [model.selection("SOLID", "Box_1_1")], keepSubResults = True)

### Create ExtrusionFuse
ExtrusionFuse_1 = model.addExtrusionFuse(Part_1_doc, [model.selection("FACE", "Cut_1_1/Modified_Face&Box_1_1/Front")], model.selection(), 0, 0.016, [model.selection("SOLID", "Cut_1_1")])

### Create Symmetry
Symmetry_1 = model.addSymmetry(Part_1_doc, [model.selection("SOLID", "ExtrusionFuse_1_1")], model.selection("EDGE", "PartSet/OY"), keepOriginal = False, keepSubResults = True)



### Export 3D model
Export_1 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "./double-ellipsoid-3d.step",
    [model.selection("SOLID", "Symmetry_1_1")])

Export_2 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "./double-ellipsoid-3d.brep",
    [model.selection("SOLID", "Symmetry_1_1")])


### Create Common for 2d slice
Common_1 = model.addCommon(Part_1_doc, [model.selection("SOLID", "Symmetry_1_1")], [model.selection("FACE", "PartSet/XOY")], keepSubResults = True)


### Export 2D face
Export_1 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "./double-ellipsoid-2d.step",
    [model.selection("FACE", "Common_1_1")])

Export_2 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "./double-ellipsoid-2d.brep",
    [model.selection("FACE", "Common_1_1")])


### Export part
Export_5 = model.exportPart(Part_1_doc, os.path.dirname(sys.argv[0]) + "./double-ellipsoid.shaperpart")


### Export to XAO
Export_6 = model.exportToXAO(Part_1_doc, os.path.dirname(sys.argv[0]) + "./double-ellipsoid.xao",
                            "Florian Correia", "double-ellipsoid")

                            
model.end()
