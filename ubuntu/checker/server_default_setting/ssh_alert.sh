#!/bin/bash

z_path="$ZinstDir/z";
etc_path="$z_path/etc";
motd_path="$etc_path/motd";

if [ ! -d $z_path ]
then
        mkdir -p $z_path;
fi

if [ ! -h $etc_path ]
then
        ln -sf /etc $etc_path;
fi

echo '**************************************************************************
* [WARNING !!]                                                           *
* If you are not authorzied to access this system, exit immediately.!!   *
* Unauthorized access to this system is forbidden by company policies,   *
* national, and international laws. Unauthorized users are subject to    *
* criminal and civil penalties as well as company initiated disciplinary *
* proceedings.                                                           *
**************************************************************************' > $motd_path
