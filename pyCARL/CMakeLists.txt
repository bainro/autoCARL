
find_package(Python3 COMPONENTS Interpreter Development)
if(NOT Python3_INCLUDE_DIRS OR NOT Python3_LIBRARY_DIRS)
	message(FATAL_ERROR "Python3 required, CMake will exit.")
endif()

find_package(SWIG 4.0 COMPONENTS python) 
include(UseSWIG)

set_property(SOURCE carlsim/carlsim.i PROPERTY CPLUSPLUS ON)

swig_add_library(pycarl 
        TYPE SHARED
        LANGUAGE python 
        SOURCES carlsim/carlsim.i )

 target_include_directories(pycarl PUBLIC ${Python3_INCLUDE_DIRS})

swig_link_libraries(pycarl PUBLIC 
    ${Python_LIBRARIES}
    carlsim
    carlsim-visual-stimulus
    carlsim-spike-generators
)

target_link_directories(pycarl PUBLIC ${Python3_LIBRARY_DIRS})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/_pycarl.so DESTINATION lib)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/carlsim.py DESTINATION lib)
