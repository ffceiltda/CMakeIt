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
# CMakeIt.cmake - main module of CMakeIt build system
#

# We requires CMake 3.14 to things work correcly
cmake_minimum_required(VERSION 3.12.0)

#
# CMAKEIT_INCLUDED - set if CMakeIt was previously included, act as include guard
#
if(CMAKEIT_INCLUDED)
	return()
endif()

set(CMAKEIT_INCLUDED ON)

#
# CMAKEIT_ROOT - point to the root of CMakeIt module files. If not set, then 
# defaults to ${CMAKE_SOURCE_DIR}/CMakeIt
#
# Example: set(CMAKEIT_ROOT ${CMAKE_SOURCE_DIR}/CMakeIt)
#
if(NOT CMAKEIT_ROOT)
	set(CMAKEIT_ROOT ${CMAKE_CURRENT_LIST_DIR})
endif()

# Add CMakeIt module path to CMake CMAKE_MODULE_PATH environment variable
if(CMAKEIT_ROOT)
	list(APPEND CMAKE_MODULE_PATH ${CMAKEIT_ROOT})
endif()

# Shows banner of CMake when called (and not configured to hide)
include(cmakeit_banner)

# Configure variables to bootstrap CMakeIt
include(cmakeit_version)
include(cmakeit_variables)
include(cmakeit_constants)

# Include external CMakeIt modules used
include(cmakeit_external_modules)

# Include custom CMakeIt functions
include(cmakeit_functions)

# Enable CMake policies
include(cmakeit_policies)

# Perform detection of toolset, compiler and target that will be used for build
include(cmakeit_detection)

# Basic CMake features needed
include(cmakeit_features)

# Define CMAKEIT_INCLUDED for next phase of build scripts
set(CMAKEIT_INCLUDED ON)
