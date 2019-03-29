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
# cmakeit_policies.cmake - CMakeIt defaults for CMake policies
#

if(NOT CMAKEIT_HIDE_BANNER)
    message(STATUS "Configuring CMake policies...")
endif()

# Enable AppleCLang policy
if(POLICY CMP0025)
    
    cmake_policy(SET CMP0025 NEW)
    
    set(CMAKE_POLICY_WARNING_CMP0025 ON)

endif()

# Enable Position Independent Executables (ASLR) policy
if(NOT (CMAKE_VERSION VERSION_LESS 3.14))
    cmake_policy(SET CMP0083 NEW)
endif()
