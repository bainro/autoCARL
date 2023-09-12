project(hello_world LANGUAGES CUDA CXX)

# Targets  
add_executable(hello_world
    src/main_hello_world.cpp
)

# definitions     
if(CARLSIM_NO_CUDA)
    target_compile_definitions(hello_world PUBLIC
        -D__NO_CUDA__ )
endif()


# Linking     
target_link_libraries(hello_world PRIVATE
    carlsim
    carlsim-stopwatchd
) 

target_include_directories(hello_world PRIVATE
    ../../tools/stopwatch
)
   
if(CARLSIM_TEST)
    #target_compile_options(hello_world PUBLIC -g -O0 -fprofile-arcs -ftest-coverage)
    target_link_libraries(hello_world PRIVATE gcov)
endif()   
        
# Installation   
install(TARGETS hello_world
    EXPORT carlsim
    RUNTIME 
        DESTINATION $<$<CONFIG:Debug>:debug/>samples 
        COMPONENT hello_world
        )

#install(FILES run_hello_world DESTINATION $<$<CONFIG:Debug>:debug/>samples)          
