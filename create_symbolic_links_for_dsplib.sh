#!/bin/bash

if [ -d dsplib_dir ]; then
    cd dsplib_dir
else
    echo "Cannot find dsplib_dir/, will quit."
    exit -1
fi


if [[ -f dsplib_c64x_latest_lib_dir/dsplib.a64 ]]; then
    ln -fs dsplib_c64x_latest_lib_dir/dsplib.a64    dsplib_c64_coff.lib
fi

if [[ -f dsplib_c64x_latest_lib_dir/dsplib.ae64 ]]; then
    ln -fs dsplib_c64x_latest_lib_dir/dsplib.ae64   dsplib_c64_elf.lib
fi

if [[ -f dsplib_c67x_latest_lib_dir/dsplib.a67 ]]; then
    ln -fs dsplib_c67x_latest_lib_dir/dsplib.a67    dsplib_c67_coff.lib
fi

# We haven't tested this yet.
# if [[ -f dsplib_c67x_latest_lib_dir/dsplib.ae67 ]]; then
#     ln -fs dsplib_c67x_latest_lib_dir/dsplib.ae67   dsplib_c67_elf.lib
# fi

if [[ -f dsplib_c64Px_latest_lib_dir/dsplib.a64P ]]; then
    ln -fs dsplib_c64Px_latest_lib_dir/dsplib.a64P  dsplib_c64plus_coff.lib
fi

if [[ -f dsplib_c64Px_latest_lib_dir/dsplib.ae64P ]]; then
    ln -fs dsplib_c64Px_latest_lib_dir/dsplib.ae64P dsplib_c64plus_elf.lib
fi

if [[ -f dsplib_c674x_latest_lib_dir/dsplib.a674 ]]; then
    ln -fs dsplib_c674x_latest_lib_dir/dsplib.a674  dsplib_c67plus_coff.lib
    ln -fs dsplib_c674x_latest_lib_dir/dsplib.a674  dsplib_c674_coff.lib
fi

if [[ -f dsplib_c674x_latest_lib_dir/dsplib.ae674 ]]; then
    ln -fs dsplib_c674x_latest_lib_dir/dsplib.ae674 dsplib_c67plus_elf.lib
    ln -fs dsplib_c674x_latest_lib_dir/dsplib.ae674 dsplib_c674_elf.lib
fi

if [[ -f dsplib_c66x_latest_lib_dir/dsplib.a66 ]]; then
    ln -fs dsplib_c66x_latest_lib_dir/dsplib.a66    dsplib_c66_coff.lib
fi

if [[ -f dsplib_c66x_latest_lib_dir/dsplib.ae66 ]]; then
    ln -fs dsplib_c66x_latest_lib_dir/dsplib.ae66   dsplib_c66_elf.lib
fi

ls -l *.lib
