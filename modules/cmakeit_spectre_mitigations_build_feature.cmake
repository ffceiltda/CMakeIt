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
# cmakeit_spectre_mitigations_build_features.cmake - CMakeIt pre-compiled header support detection for target
#   compiler / architecture / platform
#

set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS ON)
set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED OFF)

if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})

    if(MSVC_VERSION GREATER 1913)
    
        set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
        set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)

    endif()

endif()

if((CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_CLANG}) AND (NOT CYGWIN))

    if(CMAKEIT_COMPILER_CLANG_APPLE)

        if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "10.0.0"))

            set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
            set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED OFF)

        endif()

    else()

        if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "6"))

            set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)

            if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8"))
                set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)
            endif()

        endif()

    endif()

endif()

if((CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_GCC}) AND (NOT CYGWIN))

    if((CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_X86}) OR (CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_X64}))

        if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8")

            if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "7.3"))

                set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
                set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)                

            endif()

        else()

            if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "8.1"))

                set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
                set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)

            endif()

        endif()

    elseif(CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_ARM64})

        if(NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS "9"))

            set(CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS OFF)
            set(CMAKEIT_COMPILER_SPECTRE_MITIGATIONS_ADVANCED ON)

        endif()

    endif()

endif()

if(NOT CMAKEIT_COMPILER_NO_SPECTRE_MITIGATIONS)

    set(INTERNAL_CMAKEIT_REQUIRED_QUIET ${CMAKE_REQUIRED_QUIET})
    set(CMAKE_REQUIRED_QUIET ON)

    unset(CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS)
    unset(CMAKEIT_COMPILER_SPECTRE_MITIGATION_LINKER_FLAGS)

    if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)
        message(STATUS "Check if compiler support SPECTRE mitigations...")
    endif()

    if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_VISUAL_C})
        list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "/Qspectre")
    endif()

    if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_CLANG})
        
        check_cxx_compiler_flag("-mspeculative-load-hardening" INTERNAL_SPECTRE_MITIGATION_SPECULATIVE_LOAD_HARDENING)

        if(INTERNAL_SPECTRE_MITIGATION_SPECULATIVE_LOAD_HARDENING)

            list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "-mspeculative-load-hardening")

            unset(INTERNAL_SPECTRE_MITIGATION_SPECULATIVE_LOAD_HARDENING)

        else()

            check_cxx_compiler_flag("-mretpoline" INTERNAL_SPECTRE_MITIGATION_RETPOLINE)

            if(INTERNAL_SPECTRE_MITIGATION_RETPOLINE)

                list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "-mretpoline")

                unset(INTERNAL_SPECTRE_MITIGATION_SPECULATIVE_LOAD_HARDENING)

            endif()
    
        endif()
    
    endif()

    if(CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_GCC})
        
        if((CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_X86}) OR (CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_X64}))

            check_cxx_compiler_flag("-mindirect-branch=thunk" INTERNAL_SPECTRE_MITIGATION_INDIRECT_BRANCH)

            if(INTERNAL_SPECTRE_MITIGATION_INDIRECT_BRANCH)

                list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "-mindirect-branch=thunk")

                unset(INTERNAL_SPECTRE_MITIGATION_INDIRECT_BRANCH)

            endif()

            check_cxx_compiler_flag("-mindirect-branch-register" INTERNAL_SPECTRE_MITIGATION_INDIRECT_BRANCH_REGISTER)

            if(INTERNAL_SPECTRE_MITIGATION_INDIRECT_BRANCH_REGISTER)

                list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "-mindirect-branch-register")

                unset(INTERNAL_SPECTRE_MITIGATION_INDIRECT_BRANCH_REGISTER)

            endif()

            check_cxx_compiler_flag("-mfunction-return=thunk" INTERNAL_SPECTRE_MITIGATION_FUNCTION_RETURN)

            if(INTERNAL_SPECTRE_MITIGATION_FUNCTION_RETURN)

                list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "-mfunction-return=thunk")

                unset(INTERNAL_SPECTRE_MITIGATION_FUNCTION_RETURN)

            endif()

        elseif((CMAKEIT_TARGET_ARCHITECTURE STREQUAL ${CMAKEIT_TARGET_ARCHITECTURE_INTEL_ARM64}))

            check_cxx_compiler_flag("-mtrack-speculation" INTERNAL_SPECTRE_MITIGATION_TRACK_SPECULATION)

            if(INTERNAL_SPECTRE_MITIGATION_TRACK_SPECULATION)

                list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS "-mtrack-speculation")

                unset(INTERNAL_SPECTRE_MITIGATION_TRACK_SPECULATION)

            endif()

        endif()
    
    endif()

    if(CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS)    
        
        if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)
        
            message(STATUS "Check if compiler support SPECTRE mitigations... - done")
            message(STATUS "Check if linker support SPECTRE mitigations...")

        endif()

        if((CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_CLANG}) OR (CMAKEIT_COMPILER STREQUAL ${CMAKEIT_COMPILER_GCC}))

            check_cxx_compiler_flag("-Wl,-z,retpolineplt" INTERNAL_SPECTRE_MITIGATION_RETPOLINE_PLT)

            if(INTERNAL_SPECTRE_MITIGATION_RETPOLINE_PLT)

                list(APPEND CMAKEIT_COMPILER_SPECTRE_MITIGATION_LINKER_FLAGS "-Wl,-z,retpolineplt")

                unset(INTERNAL_SPECTRE_MITIGATION_RETPOLINE_PLT)

            endif()
        
        endif()

        if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)

            if(CMAKEIT_COMPILER_SPECTRE_MITIGATION_COMPILER_FLAGS)    
                message(STATUS "Check if linker support SPECTRE mitigations... - done")
            else()
                message(STATUS "Check if linker support SPECTRE mitigations... - NOTFOUND")
            endif()
        
        endif()

    else()

        if(NOT INTERNAL_CMAKEIT_REQUIRED_QUIET)
            message(STATUS "Check if compiler support SPECTRE mitigations... - NOTFOUND")
        endif()

    endif()

    set(CMAKE_REQUIRED_QUIET ${INTERNAL_CMAKEIT_REQUIRED_QUIET})
    unset(INTERNAL_CMAKEIT_REQUIRED_QUIET)
    
endif()