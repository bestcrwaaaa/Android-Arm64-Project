cmake_minimum_required(VERSION 3.22.1)

# Enable ASM language support for ARM64 assembly
enable_language(ASM)

# Project name
project("assemblyhello")

# Add the native library
add_library(
        assemblyhello
        SHARED
        src/main/cpp/native-lib.S)

# Find the log library for potential debugging
find_library(
        log-lib
        log)

# Link the log library
target_link_libraries(
        assemblyhello
        ${log-lib})
