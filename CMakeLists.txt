cmake_minimum_required(VERSION 3.15)
project(LibMimik VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# Dependencies
find_package(Protobuf REQUIRED)
include(FetchContent)

FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-1.17.0
)
FetchContent_MakeAvailable(googletest)


# Proto files location
set(PROTO_FILES
    ${CMAKE_SOURCE_DIR}/models/proto/lang.proto
    ${CMAKE_SOURCE_DIR}/models/proto/platform.proto
)

# Generated files directory
set(PROTO_GENERATED_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated)
file(MAKE_DIRECTORY ${PROTO_GENERATED_DIR})

# Generate C++ files from proto files
set(PROTO_GENERATED_FILES)
foreach(PROTO_FILE ${PROTO_FILES})
    get_filename_component(PROTO_NAME ${PROTO_FILE} NAME_WE)
    
    set(PROTO_GENERATED_HEADER ${PROTO_GENERATED_DIR}/${PROTO_NAME}.pb.h)
    set(PROTO_GENERATED_SOURCE ${PROTO_GENERATED_DIR}/${PROTO_NAME}.pb.cc)
    
    list(APPEND PROTO_GENERATED_FILES ${PROTO_GENERATED_HEADER} ${PROTO_GENERATED_SOURCE})
    
    add_custom_command(
        OUTPUT ${PROTO_GENERATED_HEADER} ${PROTO_GENERATED_SOURCE}
        COMMAND ${Protobuf_PROTOC_EXECUTABLE}
        ARGS --cpp_out=${PROTO_GENERATED_DIR}
             --proto_path=${CMAKE_SOURCE_DIR}/models/proto
             ${PROTO_FILE}
        DEPENDS ${PROTO_FILE}
        COMMENT "Generating C++ code from ${PROTO_FILE}"
        VERBATIM
    )
endforeach()

# Create protobuf library
add_library(proto_generated STATIC ${PROTO_GENERATED_FILES})
target_include_directories(proto_generated PUBLIC ${PROTO_GENERATED_DIR} ${Protobuf_INCLUDE_DIRS})
target_link_libraries(proto_generated PUBLIC ${Protobuf_LIBRARIES})

# Testing
enable_testing()

# Convenience target
add_custom_target(generate_proto DEPENDS ${PROTO_GENERATED_FILES})

# Optional: print build info
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "Generated files directory: ${PROTO_GENERATED_DIR}")
