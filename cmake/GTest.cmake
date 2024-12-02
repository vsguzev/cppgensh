include(cmake/CPM.cmake)

CPMAddPackage("gh:cpm-cmake/testpack-fibonacci@2.0")

CPMAddPackage(
  NAME googletest
  GITHUB_REPOSITORY google/googletest
  GIT_TAG release-1.12.1
  VERSION 1.12.1
  OPTIONS "INSTALL_GTEST OFF" "gtest_force_shared_crt"
)