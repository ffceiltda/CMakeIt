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
# CMakeIt-ModuleConsoleApplication.cmake - console application project template for CMakeIt
#

# Check if target plataform supports console application modules
if((${CMAKEIT_TARGET_PLATFORM} STREQUAL ${CMAKEIT_TARGET_PLATFORM_WINDOWS}) AND 
	(${CMAKEIT_TARGET_PLATFORM_VARIANT} STREQUAL ${CMAKEIT_TARGET_PLATFORM_VARIANT_WINDOWS_UWP}))
	set(CMAKEIT_MODULE_NOT_SUPPORTED ON)
endif()

set(CMAKEIT_MODULE_SUBTYPE ${CMAKEIT_MODULE_SUBTYPE_CONSOLE})

include(cmakeit_application_module_template NO_POLICY_SCOPE)
