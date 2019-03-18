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
# CMakeIt-BuildNumberGenerator.cmake - automatic generate a .cmakeit_buildnumber file
# for storing and increment automatic build numbers
#

# Check if CMakeIt.cmake was included before
if(NOT CMAKEIT_INCLUDED)
	message(FATAL_ERROR "CMakeIt.cmake was not included before including this CMakeIt module")
endif()

# Check if build number cache file exists. If not, create a new one
set(INTERNAL_MODULE_BUILD_NUMBER_CACHE_FILENAME "${CMAKE_CURRENT_SOURCE_DIR}/${CMAKEIT_BUILD_NUMBER_FILENAME}")
set(INTERNAL_MODULE_BUILD_NUMBER "")

if(EXISTS ${INTERNAL_MODULE_BUILD_NUMBER_CACHE_FILENAME})
	file(READ ${INTERNAL_MODULE_BUILD_NUMBER_CACHE_FILENAME} INTERNAL_MODULE_BUILD_NUMBER)
endif()

math(EXPR CMAKEIT_MODULE_VERSION_BUILD_NUMBER "${INTERNAL_MODULE_BUILD_NUMBER} + 1")
file(WRITE ${INTERNAL_MODULE_BUILD_NUMBER_CACHE_FILENAME} "${CMAKEIT_MODULE_VERSION_BUILD_NUMBER}")

unset(INTERNAL_MODULE_BUILD_NUMBER)
