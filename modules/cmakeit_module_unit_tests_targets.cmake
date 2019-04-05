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
# cmakeit_module_unit_tests_targets.cmake - CMake unit tests targets declaration
#

set(INTERNAL_IS_UNITTEST OFF)
set(INTERNAL_UNITTEST_FILENAME OFF)

foreach(INTERNAL_UNITTEST_FILENAME ${CMAKEIT_MODULE_UNIT_TEST_FILES})

	get_filename_component(INTERNAL_UNITTEST_BASENAME ${INTERNAL_UNITTEST_FILENAME})

	set(INTERNAL_UNITTEST_TARGET_NAME "${CMAKEIT_MODULE}_${UNITTEST_NAME}" NAME_WE)
	
	add_executable(${INTERNAL_UNITTEST_TARGET_NAME} ${INTERNAL_UNITTEST_FILENAME})

	cmakeit_target_apply_build_properties(${INTERNAL_IS_UNITTEST} ${INTERNAL_UNITTEST_TARGET_NAME})

	unset(INTERNAL_UNITTEST_TARGET_NAME)

endforeach()

unset(INTERNAL_IS_UNITTEST)
unset(INTERNAL_UNITTEST_FILENAME)
