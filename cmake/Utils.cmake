function(addJuceModule name)
    add_library(${name} STATIC)
    add_library(juce::${name} ALIAS ${name})

    file(GLOB_RECURSE headers
        CONFIGURE_DEPENDS
            "${JUCE_SOURCE_DIR}/modules/${name}/*.h"
            "${JUCE_SOURCE_DIR}/modules/${name}/*.hpp"
    )

    target_sources(${name}
        PUBLIC
            FILE_SET HEADERS
            BASE_DIRS ${JUCE_SOURCE_DIR}/modules
            FILES ${headers}
        PRIVATE
            ${JUCE_SOURCE_DIR}/modules/${name}/${name}.mm
    )
endfunction()



function(setupImportedTarget name)
    install(TARGETS ${name} FILE_SET HEADERS)

    get_target_property(compileDefs ${name} INTERFACE_COMPILE_DEFINITIONS)
    get_target_property(linkLibraries ${name} INTERFACE_LINK_LIBRARIES)
    get_target_property(includeDirectories ${name} INTERFACE_INCLUDE_DIRECTORIES)


    set(compileDefsLine "")
    if (compileDefs)
        string(REPLACE "\"" "\\\"" compileDefinitions "${compileDefs}")

        set(compileDefsLine "target_compile_definitions(${name} INTERFACE \"${compileDefinitions}\")")
    endif ()

    file(GENERATE
            OUTPUT "${CMAKE_INSTALL_PREFIX}/share/${name}.cmake"
            CONTENT
            "
add_library(${name} STATIC IMPORTED GLOBAL)
add_library(juce::${name} ALIAS ${name})

set_target_properties(${name} PROPERTIES
    IMPORTED_LOCATION \"\${JUCE_ROOT_DIR}/lib/lib${name}.a\"
    INTERFACE_INCLUDE_DIRECTORIES \"\${JUCE_ROOT_DIR}/include\"
)
${compileDefsLine}
target_link_libraries(${name} INTERFACE \"${linkLibraries}\")
")
endfunction()
