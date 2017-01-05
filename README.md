Decompose
=========

This repository contains a few applications for Cholesky Decomposition
using the S-Net coordination language.


symposdef
---------

Generates an input file for Cholesky Decomposition.
The output file consists of the lower triangle
of a symmetric positive definite matrix.

> Usage: ./symposdef [N] [-d] [-v] [-o outfile] [-t trifile]

Where N is the matrix size, outfile gives the file for the
symmetric positive definite matrix, and trifile will receive
the lower triangle of decomposed matrix.
Make sure this application is compiled with maximum optimization
as matrix sizes beyond 4096 may take many minutes to complete.


single
------

Single is a single-threaded application to do Cholesky Decomposition.
One nifty feature is that it can generate dataflow dependency graphs
for the decomposition computations. A generated graph is in Dot format.
It can be converted to PNG image file format as follows:
> dot -Nmargin=0 -Granksep=0.2 -Gmindist=0.1 -Gnodesep=0.2 -Nheight=0.1 -Nwidth=0.1 -Grankdir=TB -Nstyle=filled -Tpng -O ./single-graph-output.dot


decompose
---------

Decompose is an S-Net application to do multi-threaded Cholesky Decomposition,
which fully exposes all concurrency to the hardware.
Whenever a box function has computed a new tile it sends this tile
to the appropriate destination synchro-cells, which are indexed
using multiple index split combinators.
The S-Net source uses a feedback combinator
for efficiency reasons. It reads the input matrix from a file.


decompose2
----------

Is similar to decompose. The difference here is that it uses a star combinator.
It is slightly slower than decompose.


run
---

Is a handy script to start either of decompose or decompose2.
It generates the required input record.
> Usage: ./run [ N B inputfile outputfile ./executable -options ]

gen
---

Is similar to the run script. It generates a new input record
according to provided commandline parameters.
> Usage: ./gen [ N B inputfile outputfile ]


graphs
------
This directory contains several interesting dataflow graphs
for different P factors, where P = N / B. In addition the
corresponding PNG files are given.


Compilation
-----------

The S-Net applications require a recent snet-rts from 
git@github.com:gijsbers/snet-rts.git. This contains
two important bugfixes for reference counting.
The provided Makefile depends on some new features
in the current snetc, as of June 2013, from the SVN repository.


bench.sh
--------

Does speedup measurements. Adapt to local machine!


best.sh
--------

Does maximum performance measurements. Adapt to local machine!

