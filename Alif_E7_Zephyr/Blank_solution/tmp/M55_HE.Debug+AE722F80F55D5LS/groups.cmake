# groups.cmake

# group Source Files
add_library(Group_Source_Files OBJECT
  "${SOLUTION_ROOT}/M55_HE/main.c"
)
target_include_directories(Group_Source_Files PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_INCLUDE_DIRECTORIES>
)
target_compile_definitions(Group_Source_Files PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_DEFINITIONS>
)
add_library(Group_Source_Files_ABSTRACTIONS INTERFACE)
target_link_libraries(Group_Source_Files_ABSTRACTIONS INTERFACE
  ${CONTEXT}_ABSTRACTIONS
)
target_compile_options(Group_Source_Files PUBLIC
  $<TARGET_PROPERTY:${CONTEXT},INTERFACE_COMPILE_OPTIONS>
)
target_link_libraries(Group_Source_Files PUBLIC
  Group_Source_Files_ABSTRACTIONS
)
