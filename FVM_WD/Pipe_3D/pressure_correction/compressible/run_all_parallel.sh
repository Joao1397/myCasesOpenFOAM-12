#!/bin/bash

foamCleanTutorials

blockMesh

checkMesh

#cp system/controlDict.sp system/controlDict
cp system/controlDict.lp system/controlDict

decomposePar

#mpirun -np 4 renumberMesh -overwrite -parallel

mpirun -np 4 foamRun -parallel | tee log.solver

mpirun -np 4 foamPostProcess -func sampleDict -latestTime -parallel

gnuplot gnuplot/gnuplot_script
