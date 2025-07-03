#!/bin/bash

foamCleanTutorials
blockMesh | tee log.blockMesh
decomposePar | tee log.decomposePar_mesh
mpirun -np 8 snappyHexMesh -overwrite -parallel | tee log.snappyHexMesh
mpirun -np 8 checkMesh -latestTime -parallel | tee log.checkMesh
reconstructPar -latestTime | tee log.reconstructPar_mesh
# snappyHexMesh| tee log.snappyHexMesh
# checkMesh | tee log.checkMesh
rm -rf process*
paraFoam -builtin