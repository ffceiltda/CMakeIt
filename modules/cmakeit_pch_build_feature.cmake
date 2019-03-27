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
# cmakeit_pch_build_feature.cmake - CMakeIt pre-compiled header support detection for target
#   compiler / architecture / platform
#

# MinGW / Cygwin binutils/GCC doesn't play well with PCH...
if(MINGW OR CYGWIN)
	set(CMAKEIT_COMPILER_NO_PCH ON)
endif()

# If compiler is unrecognized, skip PCH support
if(NOT CMAKEIT_COMPILER_PCH_SUFFIX)
	set(CMAKEIT_COMPILER_NO_PCH ON)
else()
	unset(CMAKEIT_COMPILER_NO_PCH)
endif()

# Unset CMAKEIT_COMPILER_PCH_SUFFIX if was set before but CMAKEIT_COMPILER_NO_PCH was detected
if(CMAKEIT_COMPILER_NO_PCH)
	unset(CMAKEIT_COMPILER_PCH_SUFFIX)
endif()