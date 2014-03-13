#!/bin/bash

export METHODS=${METHODS:="opt oprof dbg"}

rm -rf build installed
mkdir build
cd build

../configure --with-methods="${METHODS}" \
             --prefix=$LIBMESH_DIR \
             --enable-default-comm-world \
             --enable-silent-rules \
             --enable-unique-id \
             --disable-warnings \
             --enable-openmp $*

# let LIBMESH_JOBS be either MOOSE_JOBS, or 1 if MOOSE_JOBS
# is not set (not using our package). Make will then build
# with either JOBS if set, or LIBMESH_JOBS.
LIBMESH_JOBS=${MOOSE_JOBS:-1}

make -j ${JOBS:-$LIBMESH_JOBS}
make install
