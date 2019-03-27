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
# CMakeIt-GenerateBuildScripts.cmake - write module build script files to disk
# (Makefiles, VS IDE, Xcode, etc.)
#

# Check if CMakeIt-Module*.cmake was included before
if(NOT CMAKEIT_MODULE_INCLUDED)
	message(FATAL_ERROR "No CMakeIt-Module was not included before including this CMakeIt module")
endif()

# Add module target
include(cmakeit_module_target NO_POLICY_SCOPE)

# Add unit test targets
# include(cmakeit_module_unit_tests NO_POLICY_SCOPE)
