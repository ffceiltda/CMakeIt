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
# cmakeit_compiler_detection.cmake - detect toolset used to build project
#

include(CheckPIESupported)

check_pie_supported()

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "Detecting compiler used for building...")
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")

	if(NOT CMAKEIT_COMPILER)

		set(CMAKEIT_COMPILER ${CMAKEIT_COMPILER_CLANG})
		set(CMAKEIT_COMPILER_PCH_SUFFIX ${CMAKEIT_COMPILER_PCH_SUFFIX_CLANG})

		if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "3.1")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_98})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_90})
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "3.3")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_0X)
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_99})
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "3.4")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_11)
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_99})
				
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "3.5")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_14})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})
			
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "5")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_1Z})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})
				
		else()
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_17})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})

		endif()

	endif()

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")

	if(NOT CMAKEIT_COMPILER)

		set(CMAKEIT_COMPILER ${CMAKEIT_COMPILER_CLANG})
		set(CMAKEIT_COMPILER_PCH_SUFFIX ${CMAKEIT_COMPILER_PCH_SUFFIX_CLANG})
		set(CMAKEIT_COMPILER_CLANG_APPLE ON)

		if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "425")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_98})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_90})
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "500")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_0X)
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_99})
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "503")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_11)
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_99})
				
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "600")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_14})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})
			
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "902")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_1Z})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})
				
		else()
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_17})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})

		endif()

	endif()

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")

	if(NOT CMAKEIT_COMPILER)

		set(CMAKEIT_COMPILER ${CMAKEIT_COMPILER_VISUAL_C})
		set(CMAKEIT_COMPILER_PCH_SUFFIX ${CMAKEIT_COMPILER_PCH_SUFFIX_VISUAL_C})

		if(MSVC_VERSION EQUAL 1600)
		
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_0X})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_90})
		
		elseif(MSVC_VERSION EQUAL 1900)
		
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_14})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_99})
		
		elseif(MSVC_VERSION GREATER 1909)
		
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_17})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})
		
		else()
		
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_98})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_90})
		
		endif()

	endif()

elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")

	if(NOT CMAKEIT_COMPILER)
	
		set(CMAKEIT_COMPILER ${CMAKEIT_COMPILER_GCC})
		
		# Disable PCH on MinGW
		if(NOT MINGW)
			set(CMAKEIT_COMPILER_PCH_SUFFIX ${CMAKEIT_COMPILER_PCH_SUFFIX_GCC})
		endif()

		# 'Patch' ar / ranlib utilities to correctly link
		if(CMAKE_AR STREQUAL "ar")
			set(CMAKE_AR "gcc-ar")
		endif()

		if(CMAKE_RANLIB STREQUAL "ranlib")
			set(CMAKE_RANLIB "gcc-ranlib")
		endif()
		
		if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "4.3")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_98})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_90})
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "4.8.1")
			
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_0X)
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_99})
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "5")
		
			if(CMAKE_CXX_COMPILER_VERSION VERSION_EQUAK "4.9")
					
				set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_1Y})
				set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})
				
			else()

				set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_11})
				set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})

			endif()
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "6")
				
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_14})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})		
		
		elseif(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8")
				
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_1Z})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})		
		
		else()
				
			set(CMAKEIT_COMPILER_CXX_STANDARD ${CMAKEIT_COMPILER_CXX_STANDARD_17})
			set(CMAKEIT_COMPILER_C_STANDARD ${CMAKEIT_COMPILER_C_STANDARD_11})

		endif()

	endif()

endif()

if(NOT CMAKEIT_COMPILER)
	set(CMAKEIT_COMPILER ${CMAKEIT_COMPILER_UNSPECIFIED})
endif()
