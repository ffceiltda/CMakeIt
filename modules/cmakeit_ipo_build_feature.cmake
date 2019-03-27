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
# check_ipo_build_supported.cmake - check if link-time code generation is supported
#
unset(CMAKEIT_SUPPORT_IPO)
unset(CMAKEIT_SUPPORT_IPO_MANUAL)

if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)

	if(NOT CMAKEIT_HIDE_BANNER)
		message(STATUS "Check if toolset support inter-procedural optimization...")
	endif()

endif()

check_ipo_supported(RESULT CMAKEIT_SUPPORT_IPO LANGUAGES C CXX ASM)

if(NOT CMAKEIT_SUPPORT_IPO)
	
	if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})

		if(NOT (MSVC_VERSION LESS 1400))
			set(CMAKEIT_SUPPORT_IPO_MANUAL ON)
		endif()

	endif()

endif()

if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)

	if((NOT CMAKEIT_SUPPORT_IPO) AND (NOT CMAKEIT_SUPPORT_IPO_MANUAL))
		message(STATUS "Check if toolset support inter-procedural optimization... - NOTFOUND")
	else()
		message(STATUS "Check if toolset support inter-procedural optimization... - done")
	endif()

endif()
