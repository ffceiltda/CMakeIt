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
# cmakeit_variables.cmake - variables used in CMakeIt build system
#

#
# CMAKEIT_HIDE_BANNER - hide CMakeIt banner when running CMake
#
if(NOT CMAKEIT_HIDE_BANNER)
	set(CMAKEIT_HIDE_BANNER OFF)
endif()

#
# CMAKEIT_TOOLSET - toolset detected for building (see cmakeit_constants.cmake for
# currently supported toolsets)
#
unset(CMAKEIT_TOOLSET)

#
# CMAKEIT_COMPILER - compiler that will be used within toolset (see cmakeit_constants.cmake)
# for currently supported compilers)
#
unset(CMAKEIT_COMPILER)

#
# CMAKEIT_COMPILER_PCH_SUFFIX - suffix to append to generated pre-compiled header file
#
unset(CMAKEIT_COMPILER_PCH_SUFFIX)

#
# CMAKEIT_TARGET_PLATFORM - target platform that project will be built
#
unset(CMAKEIT_TARGET_PLATFORM)

#
# CMAKEIT_TARGET_PLATFORM_VARIANT - target subsystem of platform that project will be built
#
unset(CMAKEIT_TARGET_PLATFORM_VARIANT)

#
# CMAKEIT_TARGET_ARCHITECTURE - target architecture that project will be built
#
unset(CMAKEIT_TARGET_ARCHITECTURE)

#
# CMAKEIT_BUILD_TYPE - build type: Debug, RelWithDebInfo (with debug information), Release (stripped debug information)
#
unset(CMAKEIT_BUILD_TYPE)
