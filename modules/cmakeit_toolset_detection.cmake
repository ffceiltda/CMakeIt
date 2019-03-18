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
# cmakeit_toolset_detection.cmake - detect toolset used to build project
#

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "Detecting toolset used for building...")
endif()

if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_CLANG})

	if(NOT CMAKEIT_TOOLSET)

		if(CMAKE_VS_PLATFORM_TOOLSET)
			set(CMAKEIT_TOOLSET ${CMAKEIT_TOOLSET_MICROSOFT})
		else()
			set(CMAKEIT_TOOLSET ${CMAKEIT_TOOLSET_LLVM})
		endif()
		
	endif()

elseif(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})

	if(NOT CMAKEIT_TOOLSET)
		set(CMAKEIT_TOOLSET ${CMAKEIT_TOOLSET_MICROSOFT})
	endif()

elseif(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_GCC})

	if(NOT CMAKEIT_TOOLSET)
		set(CMAKEIT_TOOLSET ${CMAKEIT_TOOLSET_GNU})
	endif()

endif()

if(NOT CMAKEIT_TOOLSET)
	set(CMAKEIT_TOOLSET ${CMAKEIT_TOOLSET_UNSPECIFIED})
endif()
