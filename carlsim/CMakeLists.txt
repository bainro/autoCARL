

# Includes
include_directories(interface/inc)
include_directories(monitor)

# Subdirectories
add_subdirectory(interface)
add_subdirectory(kernel)
add_subdirectory(monitor)

if(CARLSIM_TEST)    
    add_subdirectory(test)
    add_subdirectory(test6)
    # Removing for v1 of CI with Github Actions. @TODO add back!
    # add_subdirectory(testadv)
endif()

# add benchmark as embedded sub project
# \sa standalone sub folder
if(CARLSIM_BENCHMARKS)    
    add_subdirectory(benchmark)
endif()    
