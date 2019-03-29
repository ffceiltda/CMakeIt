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
# cmakeit_module_template.cmake - CMakeIt base module template declaration
#

# Check if CMakeIt.cmake was included before
if(NOT CMAKEIT_INCLUDED)
	message(FATAL_ERROR "CMakeIt.cmake was not included before including this CMakeIt module")
endif()

#
# This module list the variables required for a project to be delared in CMakeIt
# build system. These are below:
#

#
# CMAKEIT_MODULE_NAME - the project name (e.g.: cpp-foundation, boost)
#
if(NOT CMAKEIT_MODULE_NAME)
	message(FATAL_ERROR "Unknown CMakeIt project name (CMAKEIT_MODULE_NAME not set)")
endif()

#
# CMAKEIT_SUBMODULE_NAME (optional) - the project submodule (e.g.: project boost, submodule asio)
#
if(CMAKEIT_SUBMODULE_NAME)

	set(INTERNAL_SUBMODULE_NAME_LENGTH 0)
	
	string(LENGTH ${CMAKEIT_SUBMODULE_NAME} INTERNAL_SUBMODULE_NAME_LENGTH)
	
	if(INTERNAL_SUBMODULE_NAME_LENGTH EQUAL 0)
		message(FATAL_ERROR "Unknown CMakeIt submodule name (CMAKEIT_SUBMODULE_NAME not set)")
	endif()

	unset(INTERNAL_SUBMODULE_NAME_LENGTH)
	
endif()

#
# CMAKEIT_MODULE_TYPE - the project module type (see CMAKEIT_MODULE_TYPE_*
# in cmakeit_constants.cmake for valid values)
#
if(NOT CMAKEIT_MODULE_TYPE)
	message(FATAL_ERROR "Unknown CMakeIt project type (CMAKEIT_MODULE_TYPE not set)")
endif()

#
# CMAKEIT_MODULE_SUBTYPE - the project module subtype (see CMAKEIT_MODULE_SUBTYPE_*
# in cmakeit_constants.cmake for valid values)
#
if(NOT CMAKEIT_MODULE_SUBTYPE)
	message(FATAL_ERROR "Unknown CMakeIt project subtype (CMAKEIT_MODULE_SUBTYPE not set)")
endif()

#
# CMAKEIT_MODULE_DESCRIPTION (optional) - the description of the module to be included in resource information
#
if(NOT CMAKEIT_MODULE_DESCRIPTION)
	set(CMAKEIT_MODULE_DESCRIPTION "${CMAKEIT_MODULE_NAME} ${CMAKEIT_MODULE_NAME} ${CMAKEIT_MODULE_TYPE}")
endif()

#
# CMAKEIT_MODULE_VERSION_MAJOR (optional) - the major version number of the module to be included in resource information
#
if(NOT CMAKEIT_MODULE_VERSION_MAJOR)
	set(CMAKEIT_MODULE_VERSION_MAJOR 0)
endif()

#
# CMAKEIT_MODULE_VERSION_MINOR (optional) - the minor version number of the module to be included in resource information
#
if(NOT CMAKEIT_MODULE_VERSION_MINOR)
	set(CMAKEIT_MODULE_VERSION_MINOR 0)
endif()

#
# CMAKEIT_MODULE_REVISION_NUMBER (optional) - the revision version number of the module to be included in resource information
#
if(NOT CMAKEIT_MODULE_REVISION_NUMBER)
	set(CMAKEIT_MODULE_REVISION_NUMBER 0)
endif()

#
# CMAKEIT_MODULE_BUILD_NUMBER (optional) - the build number of the module to be included in resource information
#
if(NOT CMAKEIT_MODULE_BUILD_NUMBER)
	set(CMAKEIT_MODULE_BUILD_NUMBER 1)
endif()

#
# CMAKEIT_PRODUCT_OWNER (optional) - the name of the owner (company or person) of this project
#
if(NOT CMAKEIT_PRODUCT_OWNER)
	set(CMAKEIT_PRODUCT_OWNER "")
endif()

#
# CMAKEIT_PRODUCT_NAME (optional) - the name of the product this project belomgs to
#
if(NOT CMAKEIT_PRODUCT_NAME)
	set(CMAKEIT_PRODUCT_NAME "")
endif()

#
# CMAKEIT_DEPENDENCIES (optional) - the dependencies for the module for building
#
if(NOT CMAKEIT_DEPENDENCIES)
	set(CMAKEIT_DEPENDENCIES "")
endif()

#
# CMAKEIT_EXTERNAL_DEPENDENCIES (optional) - the external dependencies for the module for building
#
if(NOT CMAKEIT_EXTERNAL_DEPENDENCIES)
	set(CMAKEIT_EXTERNAL_DEPENDENCIES "")
endif()

#
# CMAKEIT_EXTERNAL_PUBLIC_HEADER_DIRECTORIES (optional) - the external public include directories
# dependencies for the module for building
#
if(NOT CMAKEIT_EXTERNAL_PUBLIC_HEADER_DIRECTORIES)
	set(CMAKEIT_EXTERNAL_PUBLIC_HEADER_DIRECTORIES "")
endif()

#
# CMAKEIT_EXTERNAL_PUBLIC_HEADER_DIRECTORIES (optional) - the external private include directories
# dependencies for the module for building
#
if(NOT CMAKEIT_EXTERNAL_PRIVATE_HEADER_DIRECTORIES)
	set(CMAKEIT_EXTERNAL_PRIVATE_HEADER_DIRECTORIES "")
endif()

#
# CMAKEIT_MODULE_NO_PCH (optional) - if ON, CMakeIt doesn't try to use pre-compiled headers in your module
#
if(CMAKEIT_COMPILER_NO_PCH)
	set(CMAKEIT_MODULE_NO_PCH ON)
else()
	unset(CMAKEIT_MODULE_NO_PCH)
endif()

#
# CMAKEIT_MODULE_NO_SPECTRE_MITIGATIONS (optional) - if ON, CMakeIt doesn't try to add SPECTRE mitigation flags
#
if(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS)
	set(CMAKEIT_MODULE_NO_SPECTRE_MITIGATIONS ON)
else()
	unset(CMAKEIT_MODULE_NO_SPECTRE_MITIGATIONS)
endif()

#
# CMAKEIT_MODULE_NO_UNICODE (optional) - if ON, CMakeIt doesn't try to use Unicode API versions in Windows targets
#
if(NOT CMAKEIT_MODULE_NO_UNICODE)
	set(CMAKEIT_MODULE_NO_UNICODE OFF)
endif()

#
# CMAKEIT_MODULE_C_STANDARD_REQUIRED (optional) - C standard to be used (defaults to maximum supported by compiler)
#
if(NOT CMAKEIT_MODULE_C_STANDARD_REQUIRED)
	set(CMAKEIT_MODULE_C_STANDARD_REQUIRED ${CMAKEIT_COMPILER_C_STANDARD})
endif()

#
# CMAKEIT_MODULE_C_EXTENSIONS (optional) - C standard with compiler extensions
#
if(NOT CMAKEIT_MODULE_C_EXTENSIONS)
	set(CMAKEIT_MODULE_C_EXTENSIONS OFF)
endif()

#
# CMAKEIT_MODULE_CXX_STANDARD_REQUIRED (optional) - C++ standard to be used (defaults to maximum supported by compiler)
#
if(NOT CMAKEIT_MODULE_CXX_STANDARD_REQUIRED)
	set(CMAKEIT_MODULE_CXX_STANDARD_REQUIRED ${CMAKEIT_COMPILER_CXX_STANDARD})
endif()

#
# CMAKEIT_MODULE_CXX_EXTENSIONS (optional) - C standard with compiler extensions
#
if(NOT CMAKEIT_MODULE_CXX_EXTENSIONS)
	set(CMAKEIT_MODULE_CXX_EXTENSIONS OFF)
endif()

# After this line, all variables are used internally in CMakeIt configure steps, so you can watch at
# them after your CMakeIt-Module* inclusion in your module's CMakeLists.txt 

#
# CMAKEIT_MODULE_PCH_HEADER_FILENAME (auto-generated) - location of PCH header file into module
#
unset(CMAKEIT_MODULE_PCH_HEADER_FILENAME)

#
# CMAKEIT_MODULE_PCH_HEADER_FILENAME_RELATIVE (auto-generated) - relative location of PCH header file into module
#
unset(CMAKEIT_MODULE_PCH_HEADER_FILENAME_RELATIVE)

#
# CMAKEIT_MODULE_PCH_HEADER_DIR (auto-generated) - path of PCH header file into module
#
unset(CMAKEIT_MODULE_PCH_HEADER_DIR)

#
# CMAKEIT_MODULE_PCH_SOURCE_FILENAME (auto-generated) - location of PCH source file into module
#
unset(CMAKEIT_MODULE_PCH_SOURCE_FILENAME)

#
# CMAKEIT_MODULE_PRIVATE_HEADER_DIR (auto-generated) - the full path of private header files
#
unset(CMAKEIT_MODULE_PRIVATE_HEADER_DIR)

#
# CMAKEIT_MODULE_PUBLIC_HEADER_DIR (auto-generated) - the full path of public header files
#
unset(CMAKEIT_MODULE_PUBLIC_HEADER_DIR)

#
# CMAKEIT_MODULE_SOURCE_DIR (auto-generated) - the full path of source files
#
unset(CMAKEIT_MODULE_SOURCE_DIR)

#
# CMAKEIT_MODULE_PRIVATE_HEADER_FILES (auto-generated) - the list of private header files found
#
unset(CMAKEIT_MODULE_PRIVATE_HEADER_FILES)

#
# CMAKEIT_MODULE_PUBLIC_HEADER_FILES (auto-generated) -the list of public header files found
#
unset(CMAKEIT_MODULE_PUBLIC_HEADER_FILES)

#
# CMAKEIT_MODULE_SOURCE_FILES (auto-generated) - the list of source files found
#
unset(CMAKEIT_MODULE_SOURCE_FILES)

#
# CMAKEIT_MODULE_RESOURCE_FILES (auto-generated) - the list of resource files found
#
unset(CMAKEIT_MODULE_RESOURCE_FILES)

#
# CMAKEIT_MODULE_UNIT_TEST_FILES (auto-generated) - the list of unit tests found
#
unset(CMAKEIT_MODULE_UNIT_TEST_FILES)

#
# CMAKEIT_MODULE_CONFIGURE_INPUT_FILES - nth list of input to be configured files
#
unset(CMAKEIT_MODULE_CONFIGURE_INPUT_FILES)

#
# CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES - nth list of configured output files
#
unset(CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES)

#
# CMAKEIT_MODULE_CONFIGURE_ACTIONS_TO_PERFORM - action to perform in nth configured file
#
unset(CMAKEIT_MODULE_CONFIGURE_ACTIONS_TO_PERFORM)

#
# CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR (auto-generated) - the output directory of CMake configured files for the module
#
unset(CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR)

#
# CMAKEIT_MODULE_OUTPUT_CONFIGURED_PRIVATE_HEADER_DIR (auto-generated) - the full path of configured private header files
#
unset(CMAKEIT_MODULE_OUTPUT_CONFIGURED_PRIVATE_HEADER_DIR)

#
# CMAKEIT_MODULE_OUTPUT_CONFIGURED_PUBLIC_HEADER_DIR (auto-generated) - the full path of configured public header files
#
unset(CMAKEIT_MODULE_OUTPUT_CONFIGURED_PUBLIC_HEADER_DIR)

#
# CMAKEIT_MODULE_OUTPUT_CONFIGURED_SOURCE_DIR (auto-generated) - the full path of configured source files
#
unset(CMAKEIT_MODULE_OUTPUT_CONFIGURED_SOURCE_DIR)

#
# CMAKEIT_MODULE_OUTPUT_DIR (auto-generated) - the output directory of CMake compiled binary files for the module
#
unset(CMAKEIT_MODULE_OUTPUT_DIR)

# 
# CMAKEIT_MODULE (auto-generated) - the full name for CMakeIt module
#
if(NOT CMAKEIT_SUBMODULE_NAME)
	set(CMAKEIT_MODULE "${CMAKEIT_MODULE_NAME}")
else()
	set(CMAKEIT_MODULE "${CMAKEIT_MODULE_NAME}_${CMAKEIT_SUBMODULE_NAME}")
endif()

#
# CMAKEIT_MODULE_VERSION (auto-generated) - the full version of the module to be included in resource information
#
set(CMAKEIT_MODULE_VERSION "${CMAKEIT_MODULE_VERSION_MAJOR}.${CMAKEIT_MODULE_VERSION_MINOR}.${CMAKEIT_MODULE_REVISION_NUMBER}.${CMAKEIT_MODULE_BUILD_NUMBER}")

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "| +-- Module type: ${CMAKEIT_MODULE_SUBTYPE} ${CMAKEIT_MODULE_TYPE}")
endif()

# Check if module is supported for this target architecture
if(CMAKEIT_MODULE_NOT_SUPPORTED)
	message(STATUS "| +-- Warning: this module type is not supported for target platform, skipping...")
else()

	# All variables needed are validate, so we began to declare the project here
	project(${CMAKEIT_MODULE} VERSION ${CMAKEIT_MODULE_VERSION} DESCRIPTION ${CMAKEIT_MODULE_DESCRIPTION} LANGUAGES C CXX ASM)

	# Set CMAKEIT_PROJECT_INCLUDED variable
	set(CMAKEIT_MODULE_INCLUDED ON)

	# Scan for source files of the project
	include(cmakeit_module_subtree_scanner NO_POLICY_SCOPE)

	# Detect PCH support
	include(cmakeit_module_pch_detection NO_POLICY_SCOPE)

endif()
