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
# cmakeit_module_subtree_scanner.cmake - scan for source files in module subtree
#

# Set output directories...
set(CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${CMAKEIT_MODULE}.dir")
set(CMAKEIT_MODULE_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_BUILD_TYPE}")

# Detect subtree layout...
include(cmakeit_module_subtree_layout_detection)

# Glob files for build generation
if(CMAKEIT_MODULE_PRIVATE_HEADER_DIR)

	file(GLOB_RECURSE INTERNAL_MODULE_SUBTREE_SCANNER_PRIVATE_HEADER_FILES FOLLOW_SYMLINKS
		LIST_DIRECTORIES TRUE "${CMAKEIT_MODULE_PRIVATE_HEADER_DIR}/*")

endif()

if(CMAKEIT_MODULE_PUBLIC_HEADER_DIR)

	file(GLOB_RECURSE INTERNAL_MODULE_SUBTREE_SCANNER_PUBLIC_HEADER_FILES FOLLOW_SYMLINKS
		LIST_DIRECTORIES TRUE "${CMAKEIT_MODULE_PUBLIC_HEADER_DIR}/*")

endif()

if(CMAKEIT_MODULE_SOURCE_DIR)

	file(GLOB_RECURSE INTERNAL_MODULE_SUBTREE_SCANNER_SOURCE_FILES FOLLOW_SYMLINKS
		LIST_DIRECTORIES TRUE "${CMAKEIT_MODULE_SOURCE_DIR}/*")

endif()

file(GLOB_RECURSE INTERNAL_MODULE_SUBTREE_SCANNER_ALL_FILES FOLLOW_SYMLINKS
	LIST_DIRECTORIES TRUE "${CMAKE_CURRENT_SOURCE_DIR}/*")

file(GLOB_RECURSE INTERNAL_MODULE_SUBTREE_SCANNER_UNIT_TESTS_FILES FOLLOW_SYMLINKS
	LIST_DIRECTORIES TRUE "${CMAKE_CURRENT_SOURCE_DIR}/unit_tests/*")

# iterate over all files found to build project structure
if(INTERNAL_MODULE_SUBTREE_SCANNER_PRIVATE_HEADER_FILES)

	foreach(FILENAME ${INTERNAL_MODULE_SUBTREE_SCANNER_PRIVATE_HEADER_FILES})

		list(FIND INTERNAL_MODULE_SUBTREE_SCANNER_PUBLIC_HEADER_FILES ${FILENAME} FILENAME_INDEX)

		if(FILENAME_INDEX EQUAL -1)

			cmakeit_is_header_filename(${FILENAME} INTERNAL_IS_RESULT INTERNAL_WAS_CONFIGURED INTERNAL_CONFIGURED_FILENAME)

			if(INTERNAL_IS_RESULT)
				
				if(INTERNAL_WAS_CONFIGURED)
				
					string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR} TARGET_CONFIGURED_FILENAME ${INTERNAL_CONFIGURED_FILENAME})

					list(APPEND CMAKEIT_MODULE_PRIVATE_HEADER_FILES ${TARGET_CONFIGURED_FILENAME})

					cmakeit_add_file_to_configure(${FILENAME} ${TARGET_CONFIGURED_FILENAME} ${CMAKEIT_CONFIGURE_ACTION_CONFIGURE_FILE})

				else()
					list(APPEND CMAKEIT_MODULE_PRIVATE_HEADER_FILES ${FILENAME})
				endif()

			endif()

		endif()

	endforeach()
	
endif()

if(INTERNAL_MODULE_SUBTREE_SCANNER_PUBLIC_HEADER_FILES)

	foreach(FILENAME ${INTERNAL_MODULE_SUBTREE_SCANNER_PUBLIC_HEADER_FILES})

		cmakeit_is_header_filename(${FILENAME} INTERNAL_IS_RESULT INTERNAL_WAS_CONFIGURED INTERNAL_CONFIGURED_FILENAME)

		if(INTERNAL_IS_RESULT)
			
			if(INTERNAL_WAS_CONFIGURED)
			
				string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR} TARGET_CONFIGURED_FILENAME ${INTERNAL_CONFIGURED_FILENAME})

				list(APPEND CMAKEIT_MODULE_PUBLIC_HEADER_FILES ${TARGET_CONFIGURED_FILENAME})

				cmakeit_add_file_to_configure(${FILENAME} ${TARGET_CONFIGURED_FILENAME} ${CMAKEIT_CONFIGURE_ACTION_CONFIGURE_FILE})

			else()
				list(APPEND CMAKEIT_MODULE_PUBLIC_HEADER_FILES ${FILENAME})
			endif()

		endif()

	endforeach()
	
endif()

if(INTERNAL_MODULE_SUBTREE_SCANNER_SOURCE_FILES)

	foreach(FILENAME ${INTERNAL_MODULE_SUBTREE_SCANNER_SOURCE_FILES})

		cmakeit_is_source_filename(${FILENAME} INTERNAL_IS_RESULT INTERNAL_WAS_CONFIGURED INTERNAL_CONFIGURED_FILENAME)

		if(INTERNAL_IS_RESULT)
			
			if(INTERNAL_WAS_CONFIGURED)
			
				string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR} TARGET_CONFIGURED_FILENAME ${INTERNAL_CONFIGURED_FILENAME})

				list(APPEND CMAKEIT_MODULE_SOURCE_FILES ${TARGET_CONFIGURED_FILENAME})

				cmakeit_add_file_to_configure(${FILENAME} ${TARGET_CONFIGURED_FILENAME} ${CMAKEIT_CONFIGURE_ACTION_CONFIGURE_FILE})

			else()
				list(APPEND CMAKEIT_MODULE_SOURCE_FILES ${FILENAME})
			endif()

		endif()

	endforeach()
	
endif()

if(INTERNAL_MODULE_SUBTREE_SCANNER_ALL_FILES)

	foreach(FILENAME ${INTERNAL_MODULE_SUBTREE_SCANNER_ALL_FILES})

		cmakeit_is_resource_filename(${FILENAME} INTERNAL_IS_RESULT INTERNAL_WAS_CONFIGURED INTERNAL_CONFIGURED_FILENAME)

		if(INTERNAL_IS_RESULT)
				
			if(INTERNAL_WAS_CONFIGURED)

				string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR} TARGET_CONFIGURED_FILENAME ${INTERNAL_CONFIGURED_FILENAME})

				list(APPEND CMAKEIT_MODULE_RESOURCE_FILES ${TARGET_CONFIGURED_FILENAME})

				cmakeit_add_file_to_configure(${FILENAME} ${TARGET_CONFIGURED_FILENAME} ${CMAKEIT_CONFIGURE_ACTION_CONFIGURE_FILE})

			else()
				list(APPEND CMAKEIT_MODULE_RESOURCE_FILES ${FILENAME})
			endif()
			
		endif()

	endforeach()

endif()

if(INTERNAL_MODULE_SUBTREE_SCANNER_UNIT_TESTS_FILES)

	foreach(FILENAME ${INTERNAL_MODULE_SUBTREE_SCANNER_UNIT_TESTS_FILES})

		cmakeit_is_source_filename(${FILENAME} INTERNAL_IS_RESULT INTERNAL_WAS_CONFIGURED INTERNAL_CONFIGURED_FILENAME)

		if(INTERNAL_IS_RESULT)
				
			if(INTERNAL_WAS_CONFIGURED)

				string(REPLACE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_DIR} TARGET_CONFIGURED_FILENAME ${INTERNAL_CONFIGURED_FILENAME})

				list(APPEND CMAKEIT_MODULE_UNIT_TEST_FILES ${TARGET_CONFIGURED_FILENAME})

				cmakeit_add_file_to_configure(${FILENAME} ${TARGET_CONFIGURED_FILENAME} ${CMAKEIT_CONFIGURE_ACTION_CONFIGURE_FILE})

			else()
				list(APPEND CMAKEIT_MODULE_UNIT_TEST_FILES ${FILENAME})
			endif()
			
		endif()

	endforeach()

endif()

unset(INTERNAL_IS_RESULT)
unset(INTERNAL_WAS_CONFIGURED)
unset(INTERNAL_CONFIGURED_FILENAME)
unset(INTERNAL_MODULE_SUBTREE_SCANNER_PRIVATE_HEADER_FILES)
unset(INTERNAL_MODULE_SUBTREE_SCANNER_PUBLIC_HEADER_FILES)
unset(INTERNAL_MODULE_SUBTREE_SCANNER_HEADER)
unset(INTERNAL_MODULE_SUBTREE_SCANNER_SOURCE_FILES)
unset(INTERNAL_MODULE_SUBTREE_SCANNER_ALL_FILES)
unset(INTERNAL_MODULE_SUBTREE_SCANNER_UNIT_TESTS_FILES)

if(CMAKEIT_MODULE_PRIVATE_HEADER_FILES)
	list(SORT CMAKEIT_MODULE_PRIVATE_HEADER_FILES)
endif()

if(CMAKEIT_MODULE_PUBLIC_HEADER_FILES)
	list(SORT CMAKEIT_MODULE_PUBLIC_HEADER_FILES)
endif()

if(CMAKEIT_MODULE_SOURCE_FILES)
	list(SORT CMAKEIT_MODULE_SOURCE_FILES)
endif()

if(CMAKEIT_MODULE_RESOURCE_FILES)
	list(SORT CMAKEIT_MODULE_RESOURCE_FILES)
endif()

if(CMAKEIT_MODULE_UNIT_TEST_FILES)
	list(SORT CMAKEIT_MODULE_UNIT_TEST_FILES)
endif()

if(NOT CMAKEIT_HIDE_BANNER)
	
	list(LENGTH CMAKEIT_MODULE_UNIT_TEST_FILES INTERNAL_CMAKEIT_MODULE_UNIT_TEST_FILES_LENGTH)
	
	if(INTERNAL_CMAKEIT_MODULE_UNIT_TEST_FILES_LENGTH GREATER 0)
		message(STATUS "| +-- Unit tests found: ${INTERNAL_MODULE_SUBTREE_SCANNER_UNIT_TESTS_LENGTH}")
	endif()

	unset(INTERNAL_CMAKEIT_MODULE_UNIT_TEST_FILES_LENGTH)

endif()
