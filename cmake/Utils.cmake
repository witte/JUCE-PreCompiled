function(addJuceModule name)
    add_library(${name} STATIC)
    add_library(juce::${name} ALIAS ${name})

    file(GLOB_RECURSE headers
        CONFIGURE_DEPENDS
            "${JUCE_SOURCE_DIR}/modules/${name}/*.h"
            "${JUCE_SOURCE_DIR}/modules/${name}/*.hpp"
    )

    set(ext "cpp")
    if (APPLE)
        set(ext "mm")
    endif()

    target_sources(${name}
        PUBLIC
            FILE_SET HEADERS
            BASE_DIRS ${JUCE_SOURCE_DIR}/modules
            FILES ${headers}
        PRIVATE
            ${JUCE_SOURCE_DIR}/modules/${name}/${name}.${ext}
    )
endfunction()


function(checkBigObjOnWindows name)
    if (CMAKE_SYSTEM_NAME STREQUAL "Windows")
        if ((CMAKE_CXX_COMPILER_ID STREQUAL "MSVC") OR (CMAKE_CXX_COMPILER_FRONTEND_VARIANT STREQUAL "MSVC"))
            target_compile_options(${name} PUBLIC /bigobj)
        endif()
    endif()
endfunction()



function(setupImportedTarget name)
    install(TARGETS ${name} FILE_SET HEADERS)

    get_target_property(includeDirectories ${name} INTERFACE_INCLUDE_DIRECTORIES)
    get_target_property(compileDefs ${name} INTERFACE_COMPILE_DEFINITIONS)
    get_target_property(linkLibraries ${name} INTERFACE_LINK_LIBRARIES)


    set(compileDefsLine "")
    if (compileDefs)
        string(REPLACE "\"" "\\\"" compileDefinitions "${compileDefs}")

        set(compileDefsLine "target_compile_definitions(${name} INTERFACE \"${compileDefinitions}\")")
    endif ()

    set(linkLibrariesLine "")
    if (linkLibraries)
        set(linkLibrariesLine "target_link_libraries(${name} INTERFACE \"${linkLibraries}\")")
    endif ()

    file(GENERATE
            OUTPUT "${CMAKE_INSTALL_PREFIX}/share/${name}.cmake"
            CONTENT
            "
add_library(${name} STATIC IMPORTED GLOBAL)
add_library(juce::${name} ALIAS ${name})

set_target_properties(${name} PROPERTIES
    IMPORTED_LOCATION \"\${JUCE_ROOT_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}${name}${CMAKE_STATIC_LIBRARY_SUFFIX}\"
    INTERFACE_INCLUDE_DIRECTORIES \"\${JUCE_ROOT_DIR}/include\"
)
${compileDefsLine}
${linkLibrariesLine}

")
endfunction()
