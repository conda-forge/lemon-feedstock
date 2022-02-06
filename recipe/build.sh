
#!/bin/bash

mkdir build && cd build
cmake ${CMAKE_ARGS} \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
    -DBUILD_SHARED_LIBS=1 \
    ..
make

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == "1" && "${CMAKE_CROSSCOMPILING_EMULATOR:-}" == "" ]]; then
  # Compile and run a few tests.
  make error_test bfs_test
  ./test/error_test
  ./test/bfs_test
fi

make install
