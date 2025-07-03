#!/bin/bash

foamCleanTutorials
blockMesh | tee log.blockMesh
checkMesh | tee log.checkMesh
decomposePar | tee log.decomposePar
# mpirun -np 8 renumberMesh -overwrite -parallel | tee log.renumberMesh
mpirun -np 4 foamRun -parallel | tee log.solver
# reconstructPar -latestTime | tee log.reconstructPar
mpirun -np 4 foamPostProcess -func sampleDict -latestTime -parallel | tee log.PostProcess
gnuplot gnuplot/gnuplot_script
# rm -rf process*
# paraFoam -builtin
