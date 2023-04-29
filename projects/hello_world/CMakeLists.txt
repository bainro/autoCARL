project(hello_world)

# Targets  
add_executable(hello_world
    src/main_hello_world.cpp
)

# @TODO ROB: REAPPLY CONDITIONAL i.e. IF BLOCK #DBG'ING
# definitions     
#if(CARLSIM_NO_CUDA)
    target_compile_definitions(hello_world PUBLIC
        -D__NO_CUDA__ )
#endif()

# Linking    
target_link_libraries(hello_world PRIVATE
    -static
    carlsim
    carlsim-stopwatch
)
target_include_directories(hello_world PRIVATE
    ../../tools/stopwatch
)
   
        
# Installation   
install(TARGETS hello_world
    EXPORT carlsim
    RUNTIME 
        DESTINATION $<$<CONFIG:Debug>:debug/>samples 
        COMPONENT hello_world
        )

#install(FILES run_hello_world DESTINATION $<$<CONFIG:Debug>:debug/>samples)          
