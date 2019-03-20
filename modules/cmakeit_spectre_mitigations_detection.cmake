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
# cmakeit_spectre_mitigations_detection.cmake - CMakeIt pre-compiled header support detection for target
#   compiler / architecture / platform
#

set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS ON)
set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED OFF)

if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})

    if(MSVC_VERSION GREATER 1913)
    
        set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
        set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)

    endif()

endif()

if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_CLANG})

    if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "6"))

        set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)

        if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "7"))
            set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)
        endif()

    endif()

endif()

if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_GCC})

	if((CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_X86}) OR (CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_X64}))

        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8")

            if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "7.3"))

                set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
                set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)                

            endif()

        else()

            if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8.1"))

                set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
                set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)

            endif()

        endif()

    elseif((CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_ARM64}))

        if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "9"))

            set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
            set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)

        endif()

    endif()

endif()
