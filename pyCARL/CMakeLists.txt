
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
    python3.10 # can modify as needed, not a strict requirement
    carlsim
    carlsim-visual-stimulus
    carlsim-spike-generators
)

target_link_directories(pycarl PUBLIC ${Python3_LIBRARY_DIRS})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/build/pyCARL/_pycarl.so DESTINATION include)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/build/pyCARL/carlsim.py DESTINATION include)

install(TARGETS pycarl
	EXPORT pycarl
	LIBRARY
		DESTINATION lib
		COMPONENT pycarl
) 
