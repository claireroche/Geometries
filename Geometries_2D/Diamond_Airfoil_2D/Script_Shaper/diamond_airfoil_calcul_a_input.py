from salome.shaper import model
import sys, os

model.begin()
partSet = model.moduleDocument()

### Create Part
Part_1 = model.addPart(partSet)
Part_1_doc = Part_1.document()


b1u = float(input("Enter B1u (default 44.064):") or "44.064")
ma = float(input("Enter Ma (default 1.5): ") or "1.5")
gamma = float(input("Enter gamma (default 1.4): ") or "1.4")
c = float(input("Enter chord length (default 100): ") or "100")
##A = float(input("Enter A, angle of attack (default 3): ") or "3")
##a = float(input("Enter alpha (default 10) :") or "10")

A = 3

#tan(a - A) 
taA = 2*(1/tan(radians(b1u))) * (((ma**2) * (sin(radians(b1u))**2) -1) / ((ma**2) * (gamma + cos(2*radians(b1u))) + 2))

a = A + degrees(atan(taA))

print("a = " + str(a))

##model.addParameter(partSet, "a", a, "alpha")
model.addParameter(partSet, "C", str(c), "Chord length")
model.addParameter(partSet, "a", str(a), "alpha")

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

Export_1 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "/geometries/" +"diamondairfoil_inviscid_a"+str(a)+".brep", [model.selection("FACE", "Face_1_1")])

model.end()
