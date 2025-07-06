#!/bin/bash

foamCleanTutorials

blockMesh

checkMesh

#cp system/controlDict.sp system/controlDict
cp system/controlDict.lp system/controlDict

#renumberMesh -overwrite

foamRun | tee log.solver

foamPostProcess -func sampleDict -latestTime

gnuplot gnuplot/gnuplot_script
