#
# CMakeIt - a collection of CMake modules to build programs from 'Visual Studio'-like 
# projects, and well-structure project layouts (public and private include folders,
# source folders), using CMake build system. Also features pre compiled headers
# support, unit tests, installation ('make install' style), packaging, etc.
#
# Copyright (C) 2013, Fornazin & Fornazin Consultoria em Inform�tica Ltda
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
# cmakeit_module_unit_tests_targets.cmake - CMake unit tests targets declaration
#

set(INTERNAL_IS_UNIT_TEST ON)
set(INTERNAL_UNIT_TEST_FILENAME "")

foreach(INTERNAL_UNIT_TEST_FILENAME ${CMAKEIT_MODULE_UNIT_TEST_FILES})

	get_filename_component(INTERNAL_UNIT_TEST_BASENAME ${INTERNAL_UNIT_TEST_FILENAME} NAME_WE)
	get_filename_component(INTERNAL_UNIT_TEST_EXTENSION ${INTERNAL_UNIT_TEST_FILENAME} EXT)

	if((INTERNAL_UNIT_TEST_EXTENSION STREQUAL "cc") OR (INTERNAL_UNIT_TEST_EXTENSION STREQUAL "cxx"))
		set(INTERNAL_UNIT_TEST_EXTENSION "cpp")
	endif()

	set(INTERNAL_UNIT_TEST_TARGET_NAME "${CMAKEIT_MODULE}_${INTERNAL_UNIT_TEST_BASENAME}")
	
	unset(INTERNAL_UNIT_TEST_SOURCE_FILENAMES)
	
	list(APPEND INTERNAL_UNIT_TEST_SOURCE_FILENAMES ${INTERNAL_UNIT_TEST_FILENAME})

	if(CMAKEIT_MODULE_EXTERNAL_UNIT_TEST_FILES)
	
		foreach(INTERNAL_FILENAME ${CMAKEIT_MODULE_EXTERNAL_UNIT_TEST_FILES})

			get_filename_component(INTERNAL_FILENAME_EXTENSION ${INTERNAL_FILENAME} EXT)

			if(INTERNAL_FILENAME_EXTENSION STREQUAL ${INTERNAL_UNIT_TEST_EXTENSION})
				list(APPEND INTERNAL_UNIT_TEST_SOURCE_FILENAMES ${INTERNAL_FILENAME})
			endif()

		endforeach()

		unset(INTERNAL_FILENAME_EXTENSION)
		unset(INTERNAL_FILENAME)

	endif()

	add_executable(${INTERNAL_UNIT_TEST_TARGET_NAME} ${INTERNAL_UNIT_TEST_SOURCE_FILENAMES})

	cmakeit_target_apply_build_properties(${INTERNAL_IS_UNIT_TEST} ${INTERNAL_UNIT_TEST_BASENAME})

	unset(INTERNAL_UNIT_TEST_SOURCE_FILENAMES)
	unset(INTERNAL_UNIT_TEST_TARGET_NAME)
	unset(INTERNAL_UNIT_TEST_EXTENSION)
	unset(INTERNAL_UNIT_TEST_BASENAME)

endforeach()

unset(INTERNAL_IS_UNIT_TEST)
unset(INTERNAL_UNIT_TEST_FILENAME)
