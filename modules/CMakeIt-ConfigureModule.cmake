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
# CMakeIt-ConfigureModule.cmake - configure module build system and files before build
#

# Check if CMakeIt-Module*.cmake was included before
if(NOT CMAKEIT_MODULE_INCLUDED)
	message(FATAL_ERROR "No CMakeIt-Module was not included before including this CMakeIt module")
endif()

# Check if a conifugre hook is attached...
if(CMAKEIT_CONFIGURE_HOOK)
	include(${CMAKEIT_CONFIGURE_HOOK})
endif()

if(NOT CMAKEIT_HIDE_BANNER)
	message(STATUS "| +-- Configuring project...")
endif()

list(LENGTH CMAKEIT_MODULE_CONFIGURE_INPUT_FILES INTERNAL_CMAKEIT_MODULE_CONFIGURE_INPUT_FILES_COUNT)
list(LENGTH CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES INTERNAL_CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES_COUNT)
list(LENGTH CMAKEIT_MODULE_CONFIGURE_ACTIONS_TO_PERFORM INTERNAL_CMAKEIT_MODULE_CONFIGURE_ACTIONS_TO_PERFORM_COUNT)

if(NOT (${INTERNAL_CMAKEIT_MODULE_CONFIGURE_INPUT_FILES_COUNT} EQUAL ${INTERNAL_CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES_COUNT}))
	message(FATAL_ERROR "Original and destination list of files to be configured length mismatch")
elseif(NOT (${INTERNAL_CMAKEIT_MODULE_CONFIGURE_INPUT_FILES_COUNT} EQUAL ${INTERNAL_CMAKEIT_MODULE_CONFIGURE_ACTIONS_TO_PERFORM_COUNT}))
	message(FATAL_ERROR "Original and action-to-perform list of files to be configured length mismatch")
endif()

if(${INTERNAL_CMAKEIT_MODULE_CONFIGURE_INPUT_FILES_COUNT} GREATER 0)

	math(EXPR RANGE_COUNT "${INTERNAL_CMAKEIT_MODULE_CONFIGURE_INPUT_FILES_COUNT} - 1")

	foreach(RANGE_ITEM RANGE ${RANGE_COUNT})

		list(GET CMAKEIT_MODULE_CONFIGURE_INPUT_FILES ${RANGE_ITEM} INTERNAL_CMAKEIT_CONFIGURE_INPUT_FILE)
		list(GET CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES ${RANGE_ITEM} INTERNAL_CMAKEIT_CONFIGURE_OUTPUT_FILE)
		list(GET CMAKEIT_MODULE_CONFIGURE_ACTIONS_TO_PERFORM ${RANGE_ITEM} INTERNAL_CMAKEIT_CONFIGURE_ACTION_TO_PERFORM)

		if(INTERNAL_CMAKEIT_CONFIGURE_ACTION_TO_PERFORM STREQUAL ${CMAKEIT_CONFIGURE_ACTION_CONFIGURE_FILE})
			CONFIGURE_FILE(${INTERNAL_CMAKEIT_CONFIGURE_INPUT_FILE} ${INTERNAL_CMAKEIT_CONFIGURE_OUTPUT_FILE})
		endif()

		if(INTERNAL_CMAKEIT_CONFIGURE_ACTION_TO_PERFORM STREQUAL ${CMAKEIT_CONFIGURE_ACTION_COPY_ONLY})
			CONFIGURE_FILE(${INTERNAL_CMAKEIT_CONFIGURE_INPUT_FILE} ${INTERNAL_CMAKEIT_CONFIGURE_OUTPUT_FILE} COPY_ONLY)
		endif()

	endforeach()

endif()

