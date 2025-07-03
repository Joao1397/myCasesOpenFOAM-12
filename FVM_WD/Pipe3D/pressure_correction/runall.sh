#!/bin/bash

cd incompressible
foamCleanTutorials
blockMesh
decomposePar
#mpirun -np 4 renumberMesh -overwrite -parallel
mpirun -np 4 foamRun -parallel | tee log.incompressible
mpirun -np 4 foamPostProcess -func sampleDict -latestTime -parallel
cd ..

cd compressible
foamCleanTutorials
#cp system/controlDict.sp system/controlDict
cp system/controlDict.lp system/controlDict
blockMesh
decomposePar
#mpirun -np 4 renumberMesh -overwrite -parallel
mpirun -np 4 foamRun -parallel | tee log.compressible
mpirun -np 4 foamPostProcess -func sampleDict -latestTime -parallel
cd ..

gnuplot gnuplot_script
