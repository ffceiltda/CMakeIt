#
# CMakeIt - a collection of CMake modules to build programs from 'Visual Studio'-like 
# projects, and well-structure project layouts (public and private include folders,
# source folders), using CMake build system. Also features pre compiled headers
# support, unit tests, installation ('make install' style), packaging, etc.
#
# Copyright (C) 2013, Fornazin & Fornazin Consultoria em Informática Ltda
#
# This library is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software 
# Foundation; either version 3 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT ANY 
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
# PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along 
# with this library; if not, please write to the Free Software Foundation, Inc., 
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

#
# cmakeit_version.cmake - CMakeIt build system version
#

#
# CMAKEIT_VERSION_MAJOR - the major version number of CMakeIt build system
#
set(CMAKEIT_VERSION_MAJOR 0)

#
# CMAKEIT_VERSION_MINOR - the minor version number of CMakeIt build system
#
set(CMAKEIT_VERSION_MINOR 1)

#
# CMAKEIT_REVISION_NUMBER - the revision_number of CMakeIt build system
#
set(CMAKEIT_REVISION_NUMBER 0)

#
# CMAKEIT_VERSION - the full version string of CMakeIt build system
#
set(CMAKEIT_VERSION "${CMAKEIT_VERSION_MAJOR}.${CMAKEIT_VERSION_MINOR};${CMAKEIT_REVISION_NUMBER}")
