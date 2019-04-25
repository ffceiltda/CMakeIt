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
# CMakeIt-DownloadTzData.cmake - download IANA timezone database in directory specified
#

# Check if CMakeIt.cmake was included before
if(NOT CMAKEIT_INCLUDED)
	message(FATAL_ERROR "CMakeIt.cmake was not included before including this CMakeIt module")
endif()

function(cmakeit_download_tzdata DESTINATION_PATH RESULT)

	set(${RESULT} OFF PARENT_SCOPE)

	file(MAKE_DIRECTORY "${DESTINATION_PATH}/.download")

	set(INTERNAL_TIMEZONES_PAGE_LOCAL_FILE_PATH "${DESTINATION_PATH}/.download/~tzdata_page.html")
	set(INTERNAL_TIMEZONES_PAGE_URL "https://www.iana.org/time-zones")
	set(INTERNAL_TZDATA_LOCAL_FILE_PATH "${DESTINATION_PATH}/.download/tzdata.tar.gz")
	set(INTERNAL_TZDATA_URL "")
	set(INTERNAL_TZDATA_URL_SEARCH "https://data.iana.org/time-zones/releases/tzdata")
	set(INTERNAL_TZDATA_WINDOWS_ZONE_MAPPINGS_LOCAL_FILE_PATH "${DESTINATION_PATH}/.download/windowsZones.xml")
	set(INTERNAL_TZDATA_WINDOWS_ZONE_MAPPINGS_URL "http://unicode.org/repos/cldr/trunk/common/supplemental/windowsZones.xml")
	
	string(LENGTH ${INTERNAL_TZDATA_URL_SEARCH} INTERNAL_TZDATA_URL_SEARCH_LENGTH)

	math(EXPR INTERNAL_TZDATA_URL_SEARCH_LENGTH "${INTERNAL_TZDATA_URL_SEARCH_LENGTH} + 12")

	if(${CMAKE_HOST_SYSTEM} MATCHES "^Windows")

		set(INTERNAL_TZDATA_EXTRACTOR_PATH "C:\\Program Files\\7-Zip\\7z.exe")
		list(APPEND INTERNAL_TZDATA_EXTRACTOR_ARGUMENTS "x")
		list(APPEND INTERNAL_TZDATA_EXTRACTOR_ARGUMENTS "-y")
		
	else()

		set(INTERNAL_TZDATA_EXTRACTOR_PATH "tar")
		set(INTERNAL_TZDATA_EXTRACTOR_ARGUMENTS "xvf")

	endif()

	file(REMOVE ${INTERNAL_TIMEZONES_PAGE_LOCAL_FILE_PATH})
	
	message(STATUS "Detecting IANA Timezone Database version...")

	unset(INTERNAL_DOWNLOAD_STATUS)

	file(DOWNLOAD ${INTERNAL_TIMEZONES_PAGE_URL} ${INTERNAL_TIMEZONES_PAGE_LOCAL_FILE_PATH}
		TLS_VERIFY OFF
		INACTIVITY_TIMEOUT 5
		TIMEOUT 5
		SHOW_PROGRESS
		STATUS INTERNAL_DOWNLOAD_STATUS)

	list(GET INTERNAL_DOWNLOAD_STATUS 0 INTERNAL_STATUS)

	if(${INTERNAL_STATUS} EQUAL 0)
		
		file(STRINGS ${INTERNAL_TIMEZONES_PAGE_LOCAL_FILE_PATH} INTERNAL_TZDATA_PAGE_CONTENTS)

		unset(INTERNAL_TZDATA_URL)

		foreach(INTERNAL_TZDATA_PAGE_CONTENT ${INTERNAL_TZDATA_PAGE_CONTENTS})

			if(NOT INTERNAL_TZDATA_URL)

				string(FIND "${INTERNAL_TZDATA_PAGE_CONTENT}" "${INTERNAL_TZDATA_URL_SEARCH}" INTERNAL_TZDATA_PAGE_CONTENTS_LINK_INDEX)

				if(NOT (${INTERNAL_TZDATA_PAGE_CONTENTS_LINK_INDEX} EQUAL -1))
		
					string(SUBSTRING "${INTERNAL_TZDATA_PAGE_CONTENT}" 
						${INTERNAL_TZDATA_PAGE_CONTENTS_LINK_INDEX} ${INTERNAL_TZDATA_URL_SEARCH_LENGTH}
						INTERNAL_TZDATA_URL)

				endif()

			endif()

		endforeach()

		if(INTERNAL_TZDATA_URL)

			message(STATUS "Downloading IANA Timezone Database found at url ${INTERNAL_TZDATA_URL}")

			unset(INTERNAL_DOWNLOAD_STATUS)

			file(DOWNLOAD ${INTERNAL_TZDATA_URL} ${INTERNAL_TZDATA_LOCAL_FILE_PATH}
				TLS_VERIFY OFF
				INACTIVITY_TIMEOUT 5
				TIMEOUT 60
				SHOW_PROGRESS
				STATUS INTERNAL_DOWNLOAD_STATUS)

			list(GET INTERNAL_DOWNLOAD_STATUS 0 INTERNAL_STATUS)
		
			if(${INTERNAL_STATUS} EQUAL 0)

				file(TO_NATIVE_PATH "${DESTINATION_PATH}/.download" INTERNAL_DESTINATION_PATH)

				message(STATUS "Uncompressing IANA Timezone Database in ${INTERNAL_DESTINATION_PATH}...")

				execute_process(COMMAND "${INTERNAL_TZDATA_EXTRACTOR_PATH}" 
					${INTERNAL_TZDATA_EXTRACTOR_ARGUMENTS} "tzdata.tar.gz"
					WORKING_DIRECTORY "${INTERNAL_DESTINATION_PATH}"
					OUTPUT_QUIET ERROR_QUIET
					RESULT_VARIABLE INTERNAL_EXTRACTOR_RESULT)

				if(${INTERNAL_EXTRACTOR_RESULT} STREQUAL "0")

					if(${CMAKE_HOST_SYSTEM} MATCHES "^Windows")

						execute_process(COMMAND "${INTERNAL_TZDATA_EXTRACTOR_PATH}" 
							${INTERNAL_TZDATA_EXTRACTOR_ARGUMENTS} "tzdata.tar"
							WORKING_DIRECTORY "${INTERNAL_DESTINATION_PATH}"
							OUTPUT_QUIET ERROR_QUIET
							RESULT_VARIABLE INTERNAL_EXTRACTOR_RESULT)

					endif()

				endif()

				if(${INTERNAL_EXTRACTOR_RESULT} STREQUAL "0")

					message(STATUS "Downloading UNICODE Windows Timezone's name mappings found at url ${INTERNAL_TZDATA_WINDOWS_ZONE_MAPPINGS_URL}")

					file(DOWNLOAD ${INTERNAL_TZDATA_WINDOWS_ZONE_MAPPINGS_URL} ${INTERNAL_TZDATA_WINDOWS_ZONE_MAPPINGS_LOCAL_FILE_PATH}
						TLS_VERIFY OFF
						INACTIVITY_TIMEOUT 5
						TIMEOUT 15
						SHOW_PROGRESS
						STATUS INTERNAL_DOWNLOAD_STATUS)

					list(GET INTERNAL_DOWNLOAD_STATUS 0 INTERNAL_STATUS)
		
					if(${INTERNAL_STATUS} EQUAL 0)

						set(${RESULT} ON PARENT_SCOPE)

					endif()

				endif()

			endif()

		endif()

		file(REMOVE ${INTERNAL_TIMEZONES_PAGE_LOCAL_FILE_PATH})

	endif()

endfunction()

# "africa", "antarctica", "asia", "australasia", "backward", "etcetera", "europe", "pacificnew", "northamerica", "southamerica", "systemv", "leapseconds"