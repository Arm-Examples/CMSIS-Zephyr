# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION ${CMAKE_VERSION}) # this file comes with cmake

# If CMAKE_DISABLE_SOURCE_CHANGES is set to true and the source directory is an
# existing directory in our source tree, calling file(MAKE_DIRECTORY) on it
# would cause a fatal error, even though it would be a no-op.
if(NOT EXISTS "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS")
  file(MAKE_DIRECTORY "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS")
endif()
file(MAKE_DIRECTORY
  "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/1"
  "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS"
  "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS/tmp"
  "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS/src/M55_HE.Debug+AE722F80F55D5LS-stamp"
  "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS/src"
  "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS/src/M55_HE.Debug+AE722F80F55D5LS-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS/src/M55_HE.Debug+AE722F80F55D5LS-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/MDK_Projects/Alif_E7_Zephyr/Blank_solution/tmp/M55_HE.Debug+AE722F80F55D5LS/src/M55_HE.Debug+AE722F80F55D5LS-stamp${cfgdir}") # cfgdir has leading slash
endif()
