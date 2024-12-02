# C++ Project Template Generator

A Bash script that generates a customizable C++ project template using CMake and CPM.cmake. This script streamlines the creation of new C++ projects by setting up a standardized directory structure, downloading necessary dependencies, and testing the build immediately after creation.

# Features

* Interactive Project Naming: Prompts for a project name, replacing placeholders throughout the project.
* Standard Directory Structure: Automatically creates src/, include/, tests/, and cmake/ directories.
* Dependency Management: Downloads and configures CPM.cmake for package management.
* External Modules: Fetches additional CMake modules like AddBoost.cmake and AddGTest.cmake from their original sources.
* Sample Code: Generates basic source and header files with the provided project name.
* Testing Framework: Sets up a testing environment using Google Test.
* Automatic Build and Test: Configures, compiles, and tests the project immediately after creation.

# Requirements

* CMake: Version 3.14 or higher.
* Make: Or another compatible build tool.
* C++ Compiler: Supporting at least C++17 standard.
* Internet Connection: Required for downloading dependencies.
* Bash Shell: To execute the script.

# Usage

Navigate to an empty Directory:

```bash
mkdir project_name
cd project_name
```

Run the Script via URL:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/vsguzev/cppgensh/refs/heads/main/cppgen.sh)"
```

Enter Your Project Name when prompted:

```bash
Enter your project name: MyProject
```
Wait for the Script to Complete.

### The script will:

1. Generate the project template using your project name.
2. Download necessary CMake modules and dependencies.
3. Configure and compile the project.
4. Run tests to ensure everything is set up correctly.

## Explore Your New Project:

The project is ready for development.

* Source files are located in src/.
* Header files are in include/.
* Tests are in tests/.

# Project Structure
```makefile
MyNewProject/
├── build/                  # Build directory (generated)
├── cmake/                  # CMake modules
│   ├── GTest.cmake
│   └── CPM.cmake
├── include/                # Header files
│   └── myproject.h
├── src/                    # Source files
|   ├── CMakeLists.txt
│   └── main.cpp
├── tests/                  # Test files
|   ├── CMakeLists.txt
│   └── test_main.cpp
└── CMakeLists.txt          # Root CMake configuration
```

# Customization
1. Modify the script to download additional CMake modules by adding their URLs.

### Example:

```bash
download_if_not_exist "link_to_cpm_module.cmake" "cmake/cpm_module.cmake"
```

Include the module in your CMakeLists.txt:

```cmake
include(cmake/cpm_module.cmake)
```

### Modify C++ Standards

Edit the root CMakeLists.txt to change the C++ standard:

```cmake
set(CMAKE_CXX_STANDARD 20)
```
