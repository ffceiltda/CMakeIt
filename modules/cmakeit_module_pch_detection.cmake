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
# cmakeit_module_pch_support.cmake - CMakeIt support for pre-compiled header files
#

# Check if we should ignore pre-compiled headers generation
if(NOT CMAKEIT_MODULE_NO_PCH)
	
	# Scan for known pch pairs...

	if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)

		foreach(HEADER_SUFFIX ${CMAKEIT_GLOB_HEADER_SUFFIX_LIST})
			
			foreach(SOURCE_SUFFIX ${CMAKEIT_GLOB_SOURCE_SUFFIX_LIST})
			
				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("detail/pre_compiled_headers${HEADER_SUFFIX}" "detail/pre_compiled_headers${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("pre_compiled_headers${HEADER_SUFFIX}" "pre_compiled_headers${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("detail/pch${HEADER_SUFFIX}" "detail/pch${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("detail/Pch${HEADER_SUFFIX}" "detail/Pch${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("pch${HEADER_SUFFIX}" "pch${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("Pch${HEADER_SUFFIX}" "Pch${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("stdafx${HEADER_SUFFIX}" "stdafx${SOURCE_SUFFIX}")
				endif()

				if(NOT CMAKEIT_MODULE_PCH_HEADER_FILENAME)
					cmaeit_find_pch_files("StdAfx${HEADER_SUFFIX}" "StdAfx${SOURCE_SUFFIX}")
				endif()

			endforeach()

		endforeach()
			
	endif()

	if(CMAKEIT_MODULE_PCH_HEADER_FILENAME)
	
		if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})

			set(INTERNAL_CMAKEIT_PCH_CONFIGURE OFF)
			
		elseif(CMAKEIT_MODULE_PCH_HEADER_DIR STREQUAL ${CMAKEIT_MODULE_PRIVATE_HEADER_DIR})

			set(INTERNAL_CMAKEIT_PCH_CONFIGURE ON)
			set(INTERNAL_CMAKEIT_PCH_CONFIGURE_DIR ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_PRIVATE_HEADER_DIR})

		elseif(CMAKEIT_MODULE_PCH_HEADER_DIR STREQUAL ${CMAKEIT_MODULE_PUBLIC_HEADER_DIR})

			set(INTERNAL_CMAKEIT_PCH_CONFIGURE ON)
			set(INTERNAL_CMAKEIT_PCH_CONFIGURE_DIR ${CMAKEIT_MODULE_OUTPUT_CONFIGURED_PUBLIC_HEADER_DIR})

		endif()

		if(INTERNAL_CMAKEIT_PCH_CONFIGURE)

			list(FIND CMAKEIT_MODULE_CONFIGURE_OUTPUT_FILES ${CMAKEIT_MODULE_PCH_HEADER_FILENAME} CONFIGURE_INDEX)

			if(CONFIGURE_INDEX GREATER -1)
				set(INTERNAL_CMAKEIT_PCH_CONFIGURE OFF)
			endif()

		endif()

		if(INTERNAL_CMAKEIT_PCH_CONFIGURE)

			string(REPLACE ${CMAKEIT_MODULE_PCH_HEADER_DIR} ${INTERNAL_CMAKEIT_PCH_CONFIGURE_DIR} INTERNAL_MODULE_PCH_HEADER_FILENAME ${CMAKEIT_MODULE_PCH_HEADER_FILENAME})

			configure_file(${CMAKEIT_MODULE_PCH_HEADER_FILENAME} ${INTERNAL_MODULE_PCH_HEADER_FILENAME} COPYONLY)

			list(FIND CMAKEIT_MODULE_PRIVATE_HEADER_FILES ${CMAKEIT_MODULE_PCH_HEADER_FILENAME} INTERNAL_PRIVATE_PREVIOUS_INDEX)

			if(INTERNAL_PRIVATE_PREVIOUS_INDEX GREATER -1)
				list(REMOVE_AT CMAKEIT_MODULE_PRIVATE_HEADER_FILES ${INTERNAL_PRIVATE_PREVIOUS_INDEX})
			else()

				list(FIND CMAKEIT_MODULE_PUBLIC_HEADER_FILES ${CMAKEIT_MODULE_PCH_HEADER_FILENAME} INTERNAL_PUBLIC_PREVIOUS_INDEX)

				if(INTERNAL_PUBLIC_PREVIOUS_INDEX GREATER -1)
					list(REMOVE_AT CMAKEIT_MODULE_PUBLIC_HEADER_FILES ${INTERNAL_PUBLIC_PREVIOUS_INDEX})
				endif()

			endif()

			set(CMAKEIT_MODULE_PCH_HEADER_DIR ${INTERNAL_CMAKEIT_PCH_CONFIGURE_DIR})
			set(CMAKEIT_MODULE_PCH_HEADER_FILENAME "${CMAKEIT_MODULE_PCH_HEADER_DIR}/${CMAKEIT_MODULE_PCH_HEADER_FILENAME_RELATIVE}")

			if(INTERNAL_PRIVATE_PREVIOUS_INDEX GREATER -1)

				list(APPEND CMAKEIT_MODULE_PRIVATE_HEADER_FILES ${CMAKEIT_MODULE_PCH_HEADER_FILENAME})
				list(SORT CMAKEIT_MODULE_PRIVATE_HEADER_FILES)

			elseif(INTERNAL_PUBLIC_PREVIOUS_INDEX GREATER -1)

				list(APPEND CMAKEIT_MODULE_PUBLIC_HEADER_FILES ${CMAKEIT_MODULE_PCH_HEADER_FILENAME})
				list(SORT CMAKEIT_MODULE_PUBLIC_HEADER_FILES)

			endif()

			unset(INTERNAL_CMAKEIT_PCH_CONFIGURE)
			unset(INTERNAL_CMAKEIT_PCH_CONFIGURE_DIR)
			unset(INTERNAL_MODULE_PCH_HEADER_FILENAME)
			unset(INTERNAL_PRIVATE_PREVIOUS_INDEX)
			unset(INTERNAL_PUBLIC_PREVIOUS_INDEX)

		endif()

		if((NOT CMAKEIT_HIDE_BANNER) AND (CMAKEIT_MODULE_PCH_HEADER_FILENAME))
			message(STATUS "| +-- Using pre-compiled header ${CMAKEIT_MODULE_PCH_HEADER_FILENAME_RELATIVE} for speedup build")
		endif()

	endif()

endif()