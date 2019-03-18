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
# cmakeit_module_target.cmake - CMake target declaration
#

if(CMAKEIT_MODULE_TYPE STREQUAL ${CMAKEIT_MODULE_TYPE_APPLICATION})

	if(CMAKEIT_MODULE_SUBTYPE STREQUAL ${CMAKEIT_MODULE_SUBTYPE_UI})

		add_executable(${CMAKEIT_MODULE} WIN32 MACOSX_BUNDLE 
			${CMAKEIT_MODULE_SOURCE_FILES} ${CMAKEIT_MODULE_RESOURCE_FILES})

	elseif(CMAKEIT_MODULE_SUBTYPE STREQUAL ${CMAKEIT_MODULE_SUBTYPE_CONSOLE})

		add_executable(${CMAKEIT_MODULE} 
			${CMAKEIT_MODULE_SOURCE_FILES} ${CMAKEIT_MODULE_RESOURCE_FILES})

	endif()

elseif(CMAKEIT_MODULE_TYPE STREQUAL ${CMAKEIT_MODULE_TYPE_LIBRARY})

	if(CMAKEIT_MODULE_SUBTYPE STREQUAL ${CMAKEIT_MODULE_SUBTYPE_STATIC})

		add_library(${CMAKEIT_MODULE} STATIC 
			${CMAKEIT_MODULE_SOURCE_FILES})

	elseif(CMAKEIT_MODULE_SUBTYPE STREQUAL ${CMAKEIT_MODULE_SUBTYPE_SHARED})

		add_library(${CMAKEIT_MODULE} SHARED
			${CMAKEIT_MODULE_SOURCE_FILES} ${CMAKEIT_MODULE_RESOURCE_FILES})

	endif()

endif()

set(INTERNAL_IS_UNITTEST OFF)
set(INTERNAL_UNITTEST_FILENAME OFF)

cmakeit_target_apply_build_properties(${INTERNAL_IS_UNITTEST} ${INTERNAL_UNITTEST_FILENAME})

unset(INTERNAL_IS_UNITTEST)
unset(INTERNAL_UNITTEST_FILENAME)

install(TARGETS ${CMAKEIT_MODULE}
	BUNDLE DESTINATION Applications
	FRAMEWORK DESTINATION Frameworks
	RESOURCE DESTINATION Resources
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	PUBLIC_HEADER DESTINATION include)

if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})
	install(FILES $<TARGET_PDB_FILE:${CMAKEIT_MODULE}> 
		DESTINATION bin OPTIONAL)
endif()
