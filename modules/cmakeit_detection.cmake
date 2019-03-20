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
# cmakeit_detection.cmake - perform detection of toolset, compiler and target that will be used for build
#

include(cmakeit_target_platform_detection)
include(cmakeit_compiler_detection)
include(cmakeit_toolset_detection)
include(cmakeit_target_architecture_detection)
include(cmakeit_build_type_detection)
include(cmakeit_pch_detection)
include(cmakeit_spectre_mitigations_detection)

if(NOT CMAKEIT_HIDE_BANNER)

	if(NOT CMAKEIT_COMPILER_NO_PCH)
		set(INTERNAL_CMAKEIT_PCH_SUPPORT " (with pre-compiled headers support)")
	endif()

	if(NOT CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS)
		set(INTERNAL_CMAKEIT_SPECTRE_MITIGATIONS_SUPPORT " (with SPECTRE mitigations support)")
	endif()

	string(SUBSTRING ${CMAKEIT_COMPILER_C_STANDARD} 3 3 INTERNAL_COMPILER_C_STANDARD)
	string(SUBSTRING ${CMAKEIT_COMPILER_CXX_STANDARD} 3 5 INTERNAL_COMPILER_CXX_STANDARD)
	
	message(STATUS "")
	message(STATUS "Using ${CMAKEIT_TOOLSET} toolset [using ${CMAKEIT_COMPILER} compiler, standard support is ${INTERNAL_COMPILER_CXX_STANDARD}, ${INTERNAL_COMPILER_C_STANDARD}${INTERNAL_CMAKEIT_PCH_SUPPORT}${INTERNAL_CMAKEIT_SPECTRE_MITIGATIONS_SUPPORT}]")
	message(STATUS "Targetting ${CMAKEIT_TARGET_PLATFORM} plataform [${CMAKEIT_TARGET_PLATFORM_VARIANT} variant on ${CMAKEIT_TARGET_ARCHITECTURE} architecture]")
	message(STATUS "Building ${CMAKEIT_BUILD_TYPE} configuration")
	message(STATUS "")

	unset(INTERNAL_COMPILER_C_STANDARD)
	unset(INTERNAL_COMPILER_CXX_STANDARD)
	unset(INTERNAL_CMAKEIT_PCH_SUPPORT)
	unset(INTERNAL_CMAKEIT_SPECTRE_MITIGATIONS_SUPPORT)

endif()
