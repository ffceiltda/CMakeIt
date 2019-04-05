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
# cmakeit_build_type_detection.cmake - detect build type (debug, release, etc)
#

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "Detecting build type...")
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_CONFIGURATION_TYPES STREQUAL "Debug"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_DEBUG})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Debug"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_DEBUG})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_CONFIGURATION_TYPES STREQUAL "RelWithDebInfo"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_RELWITHDEBINFO})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_RELWITHDEBINFO})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_CONFIGURATION_TYPES STREQUAL "MinSizeRel"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_MINSIZEREAL})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "MinSizeRel"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_MINSIZEREAL})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_CONFIGURATION_TYPES STREQUAL "Release"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_RELEASE})
endif()

if(NOT CMAKEIT_BUILD_TYPE AND (CMAKE_BUILD_TYPE STREQUAL "Release"))
	set(CMAKEIT_BUILD_TYPE ${CMAKEIT_BUILD_TYPE_RELEASE})
endif()

if(NOT CMAKEIT_BUILD_TYPE)
	message(FATAL_ERROR "Cannot detect build type (Debug, MinSizeRel, RelWithDebInfo, Release)")
endif()
