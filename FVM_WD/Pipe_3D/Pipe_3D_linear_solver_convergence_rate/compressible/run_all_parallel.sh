#!/bin/bash

foamListTimes -rm
rm log.*
rm *.foam
rm -rf postProcessing
rm -rf process*
blockMesh | tee log.blockMesh
checkMesh -writeSets -meshQuality -allGeometry -allTopology | tee log.checkMesh
decomposePar -force | tee log.decomposePar
mpirun -np 8 renumberMesh -overwrite -parallel | tee log.renumberMesh
mpirun -np 8 foamRun -parallel | tee log.foamRun
reconstructPar -rm | tee log.reconstructPar
rm -rf process*
# mpirun -np 8 foamPostProcess -func sampleDict -parallel | tee log.foamPostProcess
# gnuplot gnuplot/gnuplot_script
# paraFoam -builtin
# paraFoam -block -builtin

#mpirun -np 8 foamPostProcess -funcs '(vorticity PecletNo wallShearStress shearStress CourantNo Q enstrophy ﬂowType Lambda2 Q shearStress)' -parallel