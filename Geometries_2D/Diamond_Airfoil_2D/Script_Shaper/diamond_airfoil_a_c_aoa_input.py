from salome.shaper import model
import sys, os

model.begin()
partSet = model.moduleDocument()

### Create Part
Part_1 = model.addPart(partSet)
Part_1_doc = Part_1.document()

a = float(input("Enter alpha (default 10) :") or "10")
c = float(input("Enter chord length (default 100): ") or "100")
AoA = float(input("Enter Angle of Attack (default 0): ") or "0")
model.addParameter(partSet, "a", str(a), "alpha")
model.addParameter(partSet, "C", str(c), "Chord length")
model.addParameter(partSet, "AoA", str(AoA), "Angle of Attack")

### Create Sketch
Sketch_1 = model.addSketch(Part_1_doc, model.defaultPlane("XOY"))

### Create SketchLine
SketchLine_1 = Sketch_1.addLine(0, 0, 50.00000000000001, 1.746038474587389)

### Create SketchProjection
SketchProjection_1 = Sketch_1.addProjection(model.selection("VERTEX", "PartSet/Origin"), False)
SketchPoint_1 = SketchProjection_1.createdFeature()
Sketch_1.setCoincident(SketchLine_1.startPoint(), SketchPoint_1.result())

### Create SketchLine
SketchLine_2 = Sketch_1.addLine(50.00000000000001, 1.746038474587389, 100, 0)
Sketch_1.setCoincident(SketchLine_1.endPoint(), SketchLine_2.startPoint())

### Create SketchProjection
SketchProjection_2 = Sketch_1.addProjection(model.selection("EDGE", "PartSet/OX"), False)
SketchLine_3 = SketchProjection_2.createdFeature()
Sketch_1.setCoincident(SketchLine_2.endPoint(), SketchLine_3.result())

### Create SketchLine
SketchLine_4 = Sketch_1.addLine(100, 0, 50.00000000000001, -1.746038474587389)
Sketch_1.setCoincident(SketchLine_2.endPoint(), SketchLine_4.startPoint())

### Create SketchLine
SketchLine_5 = Sketch_1.addLine(50.00000000000001, -1.746038474587389, 0, 0)
Sketch_1.setCoincident(SketchLine_4.endPoint(), SketchLine_5.startPoint())
Sketch_1.setCoincident(SketchLine_1.startPoint(), SketchLine_5.endPoint())
Sketch_1.setEqual(SketchLine_1.result(), SketchLine_2.result())
Sketch_1.setEqual(SketchLine_5.result(), SketchLine_4.result())
Sketch_1.setEqual(SketchLine_4.result(), SketchLine_2.result())
Sketch_1.setHorizontalDistance(SketchLine_5.endPoint(), SketchLine_4.startPoint(), "C")

### Create SketchConstraintAngle
Sketch_1.setAngle(SketchLine_1.result(), SketchLine_5.result(), "2*a", type = "Direct")
model.do()

### Create Face
Face_1 = model.addFace(Part_1_doc, [model.selection("COMPOUND", "all-in-Sketch_1")])

Rotation_1 = model.addRotation(Part_1_doc, [model.selection("FACE", "Face_1_1")], axis = model.selection("EDGE", "PartSet/OZ"), angle = "-AoA", keepSubResults = True)

print("alpha = "+ str(a))
print("Chord Length = "+ str(c))
print("Angle of Attack = "+ str(AoA))

Export_1 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "/geometries/" +"diamondairfoil_a"+str(a)+"_c"+str(c)+"_AoA"+str(AoA)+".brep", [model.selection("FACE", "Rotation_1_1")])

model.end()
