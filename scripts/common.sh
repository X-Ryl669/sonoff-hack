#!/bin/bash

#
#  This file is part of sonoff-hack.
#  Copyright (c) 2018-2019 Davide Maggioni.
#  Copyright (c) 2020 roleo.
# 
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, version 3.
# 
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
# 
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.
#

###############################################################################
# Cameras list
###############################################################################

declare -A CAMERAS

CAMERAS["GK-200MP2B"]="GK-200MP2B"
CAMERAS["GK-200MP2C"]="GK-200MP2C"

###############################################################################
# Common functions
###############################################################################

require_root()
{
    if [ "$(whoami)" != "root" ]; then
        echo "$0 must be run as root!"
        exit 1
    fi
}

normalize_path()
{
    local path=${1//\/.\//\/}
    local npath=$(echo $path | sed -e 's;[^/][^/]*/\.\./;;')
    while [[ $npath != $path ]]; do
        path=$npath
        npath=$(echo $path | sed -e 's;[^/][^/]*/\.\./;;')
    done
    echo $path
}

check_camera_name()
{
    local CAMERA_NAME=$1
    if [[ ! ${CAMERAS[$CAMERA_NAME]+_} ]]; then
        printf "%s not found.\n\n" $CAMERA_NAME

        printf "Here's the list of supported cameras:\n\n"
        print_cameras_list 
        printf "\n"
        exit 1
    fi
}

print_cameras_list()
{
    for CAMERA_NAME in "${!CAMERAS[@]}"; do 
        printf "%s\n" $CAMERA_NAME
    done
}

get_camera_id()
{
    local CAMERA_NAME=$1
    check_camera_name $CAMERA_NAME
    echo ${CAMERAS[$CAMERA_NAME]}
}
