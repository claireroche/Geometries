# Get existing parameters names
def existingParameters(model, aDoc):
    """ Returns list of already existing parameters names"""
    #aDoc = model.activeDocument()
    aNbFeatures = aDoc.numInternalFeatures();
    aNames = dict()#[]
    for i in range(aNbFeatures):
        aParamFeature = aDoc.internalFeature(i);
        if aParamFeature is not None:
            if aParamFeature.getKind() == model.ParametersAPI_Parameter.ID():
                aNames[aParamFeature.name()] = aParamFeature.value()
    return aNames


# Execution of the Import
def importParameters(model, doc, path):
    """import parameter file"""
    # Retrieving the user input
    filepath = os.path.dirname(sys.argv[0]) + "/" + path
    print("filepath : ", filepath)
    if filepath != "" :
        # Creating the parameters in the current document
        #part = model.activeDocument()
        aNames = existingParameters(model, doc)

        with open(filepath) as file:
            for line in file:
                defParameters = line.replace("\n","").split(' ')
                #print(len(defParameters))
                if len(defParameters) >= 2 :
                    if defParameters[0] not in aNames:
                        if len(defParameters) == 2 :
                            model.addParameter(doc, defParameters[0], defParameters[1])
                        elif len(defParameters) > 2 :
                            model.addParameter(doc, defParameters[0], defParameters[1], defParameters[2])
                        aNames[defParameters[0]] = defParameters[1]
            file.close()
            return aNames

        setError("The file does not exist")

from salome.shaper import model
import sys, os

model.begin()
partSet = model.moduleDocument()

### Create Part
Part_1 = model.addPart(partSet)
Part_1_doc = Part_1.document()

params = importParameters(model, Part_1_doc, "diamond_airfoil_ac_aoa_parameters.txt")
#model.importParameters(Part_1_doc, "diamond_airfoil_parameters.txt")

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

print("alpha = "+ str(params["a"]))
print("Chord Length = "+ str(params["C"]))
print("Angle of Attack = "+ str(params["AoA"]))

Export_1 = model.exportToFile(Part_1_doc, os.path.dirname(sys.argv[0]) + "/geometries/" +"diamondairfoil_a"+str(params["a"])+"_c"+str(params["C"])+"_AoA"+str(params["AoA"])+".brep", [model.selection("FACE", "Rotation_1_1")])

model.end()
