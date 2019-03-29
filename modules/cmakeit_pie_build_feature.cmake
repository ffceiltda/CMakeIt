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
# cmakeit_pie_build_feature.cmake - check if PIE (ASLR) executables are supported
#

if(NOT (CMAKE_VERSION VERSION_LESS 3.14))

	if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)

		if(NOT CMAKEIT_HIDE_BANNER)
			message(STATUS "Check if compiler support ASLR...")
		endif()

	endif()

	unset(INTERNAL_CMAKEIT_SUPPORT_PIE)

	check_pie_supported(LANGUAGES CXX)

	if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)

		if(CMAKE_CXX_LINK_PIE_SUPPORTED)    
			message(STATUS "Check if compiler support ASLR... - done")
		else()
			message(STATUS "Check if compiler support ASLR... - NOTFOUND")
		endif()

	endif()

	unset(INTERNAL_CMAKEIT_SUPPORT_PIE)
	
endif()
