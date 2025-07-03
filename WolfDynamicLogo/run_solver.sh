#!/bin/bash

foamCleanTutorials
blockMesh | tee log.blockMesh
surfaceFeatures | tee log.surfaceFeatures
decomposePar | tee log.decomposePar
mpirun -np 8 snappyHexMesh -parallel | tee log.snappyHexMesh
# mpirun -np 2 snappyHexMesh -parallel -overwrite | tee log.snappyHexMesh
mpirun -np 8 checkMesh -latestTime -parallel | tee log.checkMesh
reconstructPar | tee log.reconstructPar
rm -rf process*
paraFoam -builtin

# cp 3/polyMesh/* constant/polyMesh
# rm -rf 1
# rm -rf 2
# rm -rf 3
# checkMesh -latestTime

# foamCleanPolyMesh # Erase the mesh information
# foamCleanTutorials # Clean all the case directory
