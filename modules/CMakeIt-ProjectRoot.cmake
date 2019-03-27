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
# CMakeIt-ProjectRoot.cmake - CMakeIt script to scan the project directory tree for CMakeLists.txt projects
#
if(NOT CMAKEIT_ROOT)
	include(${CMAKE_CURRENT_LIST_DIR}/CMakeIt.cmake NO_POLICY_SCOPE)
endif()

set(CMAKEIT_PROJECT_MODULE_COUNT 0)

message(STATUS "CMakeIt is scanning CMake project modules into subtree for building...")

file(GLOB_RECURSE INTERNAL_GLOB_PROJECT_MODULES FOLLOW_SYMLINKS
	LIST_DIRECTORIES TRUE RELATIVE "${CMAKE_SOURCE_DIR}" "${CMAKE_SOURCE_DIR}/CMakeLists.txt")

list(REMOVE_ITEM INTERNAL_GLOB_PROJECT_MODULES "CMakeLists.txt")

foreach(MODULE ${INTERNAL_GLOB_PROJECT_MODULES})

	cmakeit_ignore_prefix(${MODULE} INTERNAL_GLOB_TREESCANNER_PROJECT_IGNORE)

	if(NOT INTERNAL_GLOB_TREESCANNER_PROJECT_IGNORE)

		if(MODULE MATCHES "/CMakeLists.txt$")

			# TODO : IGNORE PATH IN LIST...

			string(REPLACE "/CMakeLists.txt" "" MODULE_DIRECTORY ${MODULE})
			message(STATUS "+-- Found CMake project module in ${MODULE_DIRECTORY} ...")
	
			add_subdirectory(${MODULE_DIRECTORY})

			math(EXPR CMAKEIT_PROJECT_MODULE_COUNT "${CMAKEIT_PROJECT_MODULE_COUNT} + 1")

		endif()

	endif()
	
endforeach()

if(NOT CMAKEIT_PROJECT_MODULE_COUNT)
	message(ERROR "* WARNING: CMakeIt found no project(s) for build")
else()		
	message(STATUS "CMakeIt found ${CMAKEIT_PROJECT_MODULE_COUNT} module(s) for build")
endif()

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "")
endif()

unset(INTERNAL_GLOB_PROJECT_MODULES)
