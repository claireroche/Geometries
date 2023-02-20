from SketchAPI import *
import sys, os
from salome.shaper import model

model.begin()
partSet = model.moduleDocument()

### Create Part
Part_1 = model.addPart(partSet)
Part_1.setName("model")
Part_1.result().setName("Part_1")
Part_1_doc = Part_1.document()
model.addParameter(Part_1_doc, "flare", '33')
model.addParameter(Part_1_doc, "nose", '2.5')

### Create Sketch
Sketch_1 = model.addSketch(Part_1_doc, model.defaultPlane("XOY"))

### Create SketchLine
SketchLine_1 = Sketch_1.addLine(2.195326641487131, 2.481365379103305, 1118.01, 139.4861800964465)

### Create SketchProjection
SketchProjection_1 = Sketch_1.addProjection(model.selection("VERTEX", "PartSet/Origin"), False)
SketchPoint_1 = SketchProjection_1.createdFeature()

### Create SketchLine
SketchLine_2 = Sketch_1.addLine(1118.01, 139.4861800964465, 1618.01, 139.4861800964465)
Sketch_1.setCoincident(SketchLine_1.endPoint(), SketchLine_2.startPoint())

### Create SketchLine
SketchLine_3 = Sketch_1.addLine(1618.01, 139.4861800964465, 1671.79, 174.4113204586086)
Sketch_1.setCoincident(SketchLine_2.endPoint(), SketchLine_3.startPoint())

### Create SketchLine
SketchLine_4 = Sketch_1.addLine(1671.79, 174.4113204586086, 1925.79, 174.4113204586086)
Sketch_1.setCoincident(SketchLine_3.endPoint(), SketchLine_4.startPoint())

### Create SketchLine
SketchLine_5 = Sketch_1.addLine(1925.79, 174.4113204586086, 1925.79, 0)
Sketch_1.setCoincident(SketchLine_4.endPoint(), SketchLine_5.startPoint())
Sketch_1.setVertical(SketchLine_5.result())
Sketch_1.setHorizontalDistance(SketchAPI_Point(SketchPoint_1).coordinates(), SketchLine_1.endPoint(), 1118.01)
Sketch_1.setHorizontalDistance(SketchAPI_Point(SketchPoint_1).coordinates(), SketchLine_2.endPoint(), 1618.01)
Sketch_1.setHorizontalDistance(SketchAPI_Point(SketchPoint_1).coordinates(), SketchLine_3.endPoint(), 1671.79)

### Create SketchConstraintAngle
Sketch_1.setAngle(SketchLine_3.result(), SketchLine_2.result(), "flare", type = "Supplementary")
Sketch_1.setHorizontal(SketchLine_2.result())

### Create SketchLine
SketchLine_6 = Sketch_1.addLine(1925.79, 0, 0, 0)
Sketch_1.setCoincident(SketchLine_5.endPoint(), SketchLine_6.startPoint())
Sketch_1.setCoincident(SketchAPI_Point(SketchPoint_1).coordinates(), SketchLine_6.endPoint())

### Create SketchArc
SketchArc_1 = Sketch_1.addArc(2.5, 0, 0, 0, 2.195326641487131, 2.481365379103305, True)
Sketch_1.setCoincident(SketchLine_6.result(), SketchArc_1.center())
Sketch_1.setCoincident(SketchAPI_Point(SketchPoint_1).coordinates(), SketchArc_1.startPoint())
Sketch_1.setCoincident(SketchArc_1.endPoint(), SketchLine_1.startPoint())
Sketch_1.setTangent(SketchArc_1.results()[1], SketchLine_1.result())
Sketch_1.setHorizontal(SketchLine_6.result())
Sketch_1.setRadius(SketchArc_1.results()[1], "nose")

### Create SketchConstraintAngle
Sketch_1.setAngle(SketchLine_1.result(), SketchLine_6.result(), 7, type = "Direct")
Sketch_1.setHorizontal(SketchLine_4.result())
Sketch_1.setHorizontalDistance(SketchLine_3.endPoint(), SketchLine_5.startPoint(), 254)
model.do()
Sketch_1.result().setName("Sketch_1_Copy")

### Create Revolution
Revolution_1 = model.addRevolution(Part_1_doc, [model.selection("COMPOUND", "all-in-Sketch_1")], model.selection("EDGE", "PartSet/OX"), 360, 0, "Edges")

### Export 3D model
Export_1 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "./HIFiRE-I-basic-3d.step",
    [model.selection("SOLID", "Revolution_1_1")])

Export_2 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "./HIFiRE-I-basic-3d.brep",
    [model.selection("SOLID", "Revolution_1_1")])

model.do()


### Create Part
Part_2 = model.addPart(partSet)
Part_2.setName("coupe")
Part_2.result().setName("Part_2")
Part_2_doc = Part_2.document()
model.addParameter(Part_2_doc, "flare", '33')
model.addParameter(Part_2_doc, "nose", '2.5')

### Create Sketch
Sketch_2 = model.addSketch(Part_2_doc, model.defaultPlane("XOY"))

### Create SketchLine
SketchLine_7 = Sketch_2.addLine(2.195326641487131, 2.481365379103305, 1118.01, 139.4861800964465)

### Create SketchProjection
SketchProjection_2 = Sketch_2.addProjection(model.selection("VERTEX", "PartSet/Origin"), False)
SketchPoint_2 = SketchProjection_2.createdFeature()

### Create SketchLine
SketchLine_8 = Sketch_2.addLine(1118.01, 139.4861800964465, 1618.01, 139.4861800964465)
Sketch_2.setCoincident(SketchLine_7.endPoint(), SketchLine_8.startPoint())

### Create SketchLine
SketchLine_9 = Sketch_2.addLine(1618.01, 139.4861800964465, 1671.79, 174.4113204586086)
Sketch_2.setCoincident(SketchLine_8.endPoint(), SketchLine_9.startPoint())

### Create SketchLine
SketchLine_10 = Sketch_2.addLine(1671.79, 174.4113204586086, 1925.79, 174.4113204586086)
Sketch_2.setCoincident(SketchLine_9.endPoint(), SketchLine_10.startPoint())

### Create SketchLine
SketchLine_11 = Sketch_2.addLine(1925.79, 174.4113204586086, 1925.79, 0)
Sketch_2.setCoincident(SketchLine_10.endPoint(), SketchLine_11.startPoint())
Sketch_2.setVertical(SketchLine_11.result())
Sketch_2.setHorizontalDistance(SketchAPI_Point(SketchPoint_2).coordinates(), SketchLine_7.endPoint(), 1118.01)
Sketch_2.setHorizontalDistance(SketchAPI_Point(SketchPoint_2).coordinates(), SketchLine_8.endPoint(), 1618.01)
Sketch_2.setHorizontalDistance(SketchAPI_Point(SketchPoint_2).coordinates(), SketchLine_9.endPoint(), 1671.79)

### Create SketchConstraintAngle
Sketch_2.setAngle(SketchLine_9.result(), SketchLine_8.result(), "flare", type = "Supplementary")
Sketch_2.setHorizontal(SketchLine_8.result())

### Create SketchLine
SketchLine_12 = Sketch_2.addLine(1925.79, 0, 0, 0)
Sketch_2.setCoincident(SketchLine_11.endPoint(), SketchLine_12.startPoint())
Sketch_2.setCoincident(SketchAPI_Point(SketchPoint_2).coordinates(), SketchLine_12.endPoint())

### Create SketchArc
SketchArc_2 = Sketch_2.addArc(2.5, 0, 0, 0, 2.195326641487131, 2.481365379103305, True)
Sketch_2.setCoincident(SketchLine_12.result(), SketchArc_2.center())
Sketch_2.setCoincident(SketchAPI_Point(SketchPoint_2).coordinates(), SketchArc_2.startPoint())
Sketch_2.setCoincident(SketchArc_2.endPoint(), SketchLine_7.startPoint())
Sketch_2.setTangent(SketchArc_2.results()[1], SketchLine_7.result())
Sketch_2.setHorizontal(SketchLine_12.result())
Sketch_2.setRadius(SketchArc_2.results()[1], "nose")

### Create SketchConstraintAngle
Sketch_2.setAngle(SketchLine_7.result(), SketchLine_12.result(), 7, type = "Direct")
Sketch_2.setHorizontal(SketchLine_10.result())
Sketch_2.setHorizontalDistance(SketchLine_9.endPoint(), SketchLine_11.startPoint(), 254)
model.do()
Sketch_2.result().setName("Sketch_1_Copy")

### Create Revolution
Revolution_2 = model.addRevolution(Part_2_doc, [model.selection("FACE", "Sketch_1_Copy/Face-SketchArc_1_2f-SketchLine_6r-SketchLine_5r-SketchLine_4r-SketchLine_3r-SketchLine_2r-SketchLine_1r")], model.selection("EDGE", "PartSet/OX"), 360, 0)


### Create Common for 2d slice
Common_1 = model.addCommon(Part_2_doc, [model.selection("SOLID", "Revolution_1_1")], [model.selection("FACE", "PartSet/XOY")], keepSubResults = True)


### Export 2D face
Export_1 = model.exportToFile(Part_2_doc, os.path.dirname(sys.argv[0]) + "./HIFiRE-I-basic-2d.step",
    [model.selection("FACE", "Common_1_1")])

Export_2 = model.exportToFile(Part_2_doc, os.path.dirname(sys.argv[0]) + "./HIFiRE-I-basic-2d.brep",
    [model.selection("FACE", "Common_1_1")])


### Export part
Export_5 = model.exportPart(Part_2_doc, os.path.dirname(sys.argv[0]) + "./HIFiRE-I-basic.shaperpart")


### Export to XAO
Export_6 = model.exportToXAO(Part_2_doc, os.path.dirname(sys.argv[0]) + "./HIFiRE-I-basic.xao",
                            "Florian Correia", "HIFiRE-I-basic")



model.do()

model.end()
