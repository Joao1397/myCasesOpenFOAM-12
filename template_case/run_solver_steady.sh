#!/bin/bash

foamCleanTutorials
extrudeMesh | tee log.extrudeMesh_steady
createPatch -overwrite | tee log.createPatch_steady
decomposePar | tee log.decomposePar_steady
mpirun -np 8 renumberMesh -overwrite -parallel | tee log.renumberMesh_steady
mpirun -np 8 foamRun -solver incompressibleFluid -parallel | tee log.solver_steady
reconstructPar -latestTime | tee log.reconstructPar_steady
foamPostProcess -func sampleDict -latestTime | tee log.PostProcess
rm -rf process*
paraFoam -builtin
