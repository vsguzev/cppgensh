#!/bin/bash

# Function to download a file if it doesn't exist
download_if_not_exist() {
  local url="$1"
  local output="$2"
  if [ ! -f "$output" ]; then
    mkdir -p "$(dirname "$output")"
    echo "Downloading $(basename "$output")..."
    curl -sSL "$url" -o "$output"
  fi
}

# Download CPM.cmake
download_if_not_exist "https://raw.githubusercontent.com/cpm-cmake/CPM.cmake/refs/heads/master/cmake/CPM.cmake" "cmake/CPM.cmake"

# Download additional CMake modules (e.g., GTest.cmake)
echo "Downloading additional CMake modules..."
download_if_not_exist "https://raw.githubusercontent.com/vsguzev/cppgensh/refs/heads/main/cmake/GTest.cmake" "cmake/GTest.cmake"

# Create directory structure
echo "Creating directory structure..."
mkdir -p src include tests

# Create root CMakeLists.txt
echo "Generating root CMakeLists.txt..."
cat <<EOL > CMakeLists.txt
cmake_minimum_required(VERSION 3.14)
project(MyProject VERSION 0.1.0 LANGUAGES CXX)

# Include CPM.cmake
include(cmake/CPM.cmake)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add subdirectories
add_subdirectory(src)
add_subdirectory(tests)

# Include additional modules (comment if you don't want them to build)
EOL

# Add additional CMake modules (e.g., GTest.cmake)
echo 'include(cmake/GTest.cmake)' >> CMakeLists.txt

# Create src/CMakeLists.txt
echo "Generating src/CMakeLists.txt..."
cat <<EOL > src/CMakeLists.txt
add_library(\${PROJECT_NAME} STATIC)

target_sources(\${PROJECT_NAME}
  PRIVATE
    main.cpp
)

target_include_directories(\${PROJECT_NAME}
  PUBLIC
    \${CMAKE_CURRENT_SOURCE_DIR}/../include
)
EOL

# Create tests/CMakeLists.txt
echo "Generating tests/CMakeLists.txt..."
cat <<EOL > tests/CMakeLists.txt
add_executable(\${PROJECT_NAME}_tests test_main.cpp)

target_link_libraries(\${PROJECT_NAME}_tests
  PRIVATE
    \${PROJECT_NAME}
    fibonacci
    gtest
    gtest_main
    gmock
)

enable_testing()
add_test(NAME \${PROJECT_NAME}_tests COMMAND \${PROJECT_NAME}_tests)
EOL

# Create source file
echo "Generating src/main.cpp..."
cat <<EOL > src/main.cpp
#include "myproject.h"

int main() {
  return 0;
}
EOL

# Create header file
echo "Generating include/myproject.h..."
cat <<EOL > include/myproject.h
#pragma once

void say_hello();
EOL

# Create test file
echo "Generating tests/test_main.cpp..."
cat <<EOL > tests/test_main.cpp
#include "myproject.h"
#include <gtest/gtest.h>

TEST(SampleTest, AssertionTrue) {
  EXPECT_TRUE(true);
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
EOL

# Inform the user
echo "Project template created successfully."

# Check for required commands
command -v cmake >/dev/null 2>&1 || { echo >&2 "CMake is required but it's not installed. Aborting."; exit 1; }
command -v make >/dev/null 2>&1 || { echo >&2 "Make is required but it's not installed. Aborting."; exit 1; }

# Create build directory
echo "Creating build directory..."
mkdir -p build
cd build

# Run CMake to configure the project
echo "Configuring the project with CMake..."
cmake .. || { echo "CMake configuration failed. Aborting."; exit 1; }

# Compile the project
echo "Compiling the project..."
cmake --build . || { echo "Build failed. Aborting."; exit 1; }

# Run tests
echo "Running tests..."
ctest || { echo "Tests failed."; exit 1; }

# Inform the user
echo "Project compiled and tests ran successfully."