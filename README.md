Collection of geometries 2D and 3D, mostly for Computational Fluid Dynamics.

In the document **img.pdf**, you can see some illustrations of geometries of this repository. We decided to represent all the geometries by a triangulation of the surface of the geometry.

# Formats
* .hdf: This is the studies format of the CAO Software Shaper, from the [Salome](https://docs.salome-platform.org/latest/main/index.html) platform.
* .brep: This is a representation of a solid by its surfaces. This is at least readable by [Gmsh](https://gmsh.info/) and [Salome](https://www.salome-platform.org/).
* .step: This is at least readable by [Gmsh](https://gmsh.info/) and [Salome](https://docs.salome-platform.org/latest/main/index.html).
* .geo: This is a CAO format. This format is readable by [Gmsh](https://gmsh.info/).

I can assure you all the _.geo_ files work well with the 4.9.5 version of _GMSH_. I can not guarantee the result with other versions.

**WARNING:** in some _.geo_ files, you also can find informations linked to the mesh. I invite you to delete those sections if not needed.

# Geometries 2D

### C?_2D
These are elementary test geometries.

### NACA_2D
Find more information on the [NASA-NACA website](https://turbmodels.larc.nasa.gov/naca0012_val.html). The geometry made here is the one with x between 0 and 1.

# Geometries 3D

### C?_3D
These are elementary test geometries. There are some lines about mesh at the bottom of the .geo files. You can easily remove these lines to get only the geometry.

* _Surface.geo: This is a geometry with a surface mesh, made with transfinite (_ex: C6_3D_Surface.geo_).
* _inSphere.geo: The volume is now the space between the geometry (the object) and a farfield sphere (_ex: C6_3D_inSphere.geo_).

**Attention:** C1_3D for exemple is not a 3D extension of C1_2D.


# Documentation for CFD
This part is a list of some articles using these geometries for CFD.

### Apollo
* Thesis ["NUMERICAL SIMULATION OF
  WEAKLY IONIZED HYPERSONIC
  FLOW OVER REENTRY CAPSULES"](https://web.archive.org/web/20170809050846id_/http://ngpdlab.engin.umich.edu/files/papers/Scalabrin.pdf)

[//]: <> (<img src="./img/Apollo_2D.png" alt="Test" style="height: 50px; width:50px;"/>)

### Caretwing
* ["Hypersonic aircraft and their aerodynamic problems"](https://www.sciencedirect.com/science/article/pii/0376042165900060)

### Cone Cylinder Flare (CCF)
* ["Flow and Stability Analysis of a Hypersonic Boundary Layer over an Axisymmetric Cone Cylinder Flare Configuration"](https://arc.aiaa.org/doi/abs/10.2514/6.2019-2115)

### Diamond Airfoil
* ["Entropic
  lattice Boltzmann model for gas dynamics: Theory,
  boundary conditions, and implementation"](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.93.063302)

### Double Cone
* ["Assessment of CFD Capability for Hypersonic Shock
  Wave Laminar Boundary Layer Interactions"](https://www.mdpi.com/2226-4310/4/2/25)

### Double Ellipsoid

* ["Hypersonic Flows for Reentry Problems"](https://link.springer.com/book/10.1007/978-3-642-76527-8), ["Problem 6 - Double (Simple) Ellipsoid"](https://link.springer.com/content/pdf/10.1007/978-3-642-76527-8_6.pdf)
* ["Experimental study of the flow around a double ellipsoid configuration"](https://link.springer.com/chapter/10.1007/978-3-642-76527-8_27)
* ["Immersed boundaries in hypersonic flows with considerations about high-fidelity and massive parallelism"](https://www.researchgate.net/profile/Thibault-Bridel-Bertomeu/publication/362945337_Immersed_Boundaries_In_Hypersonic_Flows_With_Considerations_About_High-Fidelity_and_Massive_Parallelism/links/630887bb61e4553b953c33fe/Immersed-Boundaries-In-Hypersonic-Flows-With-Considerations-About-High-Fidelity-and-Massive-Parallelism.pdf)

### Fire II
* ["Numerical Simulations of the FIRE-II Convective and
  Radiative Heating Rates"](https://arc.aiaa.org/doi/abs/10.2514/6.2007-4044)
* Thesis ["NUMERICAL SIMULATION OF
    WEAKLY IONIZED HYPERSONIC
    FLOW OVER REENTRY CAPSULES"](https://web.archive.org/web/20170809050846id_/http://ngpdlab.engin.umich.edu/files/papers/Scalabrin.pdf)

### HB-2
* ["Investigation of Flow Field in a Typical Hypersonic Wind Tunnel over a Standard Mode"](https://www.jafmonline.net/JournalArchive/article_1406_5398e030ad9578c4091a0621d36f5ee1.pdf)
* ["FORCE TESTS OF STANDARD HYPERVELOCITY BALLISTIC MODELS HB-1 AND HB-2 AT MACH 1.5 TO 10"](https://apps.dtic.mil/sti/pdfs/AD0412651.pdf)

### HIFIRE I
* ["Fifty Years of Shock-Wave/Boundary-Layer Interaction Research: What Next?"](https://arc.aiaa.org/doi/abs/10.2514/2.1476)

### HyTRV
* [Direct numerical simulation of hypersonic
  boundary layer transition over a lifting-
  body model HyTRV](https://link.springer.com/content/pdf/10.1186/s42774-021-00082-x.pdf?pdf=button%20sticky)

### Mars Spacecraft
* ["Development of an Unstructured Navier-Stokes Solver
  For Hypersonic Nonequilibrium Aerothermodynamics"](https://arc.aiaa.org/doi/abs/10.2514/6.2005-5203)
* Thesis ["NUMERICAL SIMULATION OF
  WEAKLY IONIZED HYPERSONIC
  FLOW OVER REENTRY CAPSULES"](https://web.archive.org/web/20170809050846id_/http://ngpdlab.engin.umich.edu/files/papers/Scalabrin.pdf)

### NACA 0012
Find more information on the [NASA-NACA website](https://turbmodels.larc.nasa.gov/naca0012_val.html).
Technical reports are available with experimental data sets.
* ["Entropic
  lattice Boltzmann model for gas dynamics: Theory,
  boundary conditions, and implementation"](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.93.063302)

### Orex
* ["Numerical Studies of Influences of Hall Effect on MHD Flow
  Control around Blunt Body OREX"](https://arc.aiaa.org/doi/abs/10.2514/6.2004-2561)
* ["Numerical Analyses on Flow Control Around Blunt Body "OREX" by Magnetic Field"](https://arc.aiaa.org/doi/abs/10.2514/6.2003-3760)
* ["Influences of Electrical Conductivity of Wall on
  Magnetohydrodynamic Control of Aerodynamic Heating"](https://arc.aiaa.org/doi/abs/10.2514/1.13770?journalCode=jsr)
* ["Performance Characteristics of Onboard Hall-Type
  Magnetohydrodynamic Generator
  During Earth Reentry Flight"](https://arc.aiaa.org/doi/abs/10.2514/1.B35364)
* ["Numerical Modeling of Plasma Manipulation Using an
  ExB Layer in a Hypersonic Boundary Layer"](https://arc.aiaa.org/doi/abs/10.2514/6.2009-3732)

### RAM-C II
* Thesis ["NUMERICAL SIMULATION OF
  WEAKLY IONIZED HYPERSONIC
  FLOW OVER REENTRY CAPSULES"](https://web.archive.org/web/20170809050846id_/http://ngpdlab.engin.umich.edu/files/papers/Scalabrin.pdf)
* ["Numerical Prediction of Hypersonic Flowfields Including Effects
  of Electron Translational Nonequilibrium"](https://arc.aiaa.org/doi/10.2514/1.T3963)

### Stardust
* ["Numerical Prediction of Hypersonic Flowfields Including Effects
  of Electron Translational Nonequilibrium"](https://arc.aiaa.org/doi/10.2514/1.T3963)



I would like to thank the people who helped me to build this repository, by sending me docs, and geometries in different formats.
