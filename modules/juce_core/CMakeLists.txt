addJuceModule(juce_core)

target_sources(juce_core
    PRIVATE
        ${JUCE_SOURCE_DIR}/modules/juce_core/juce_core_CompilationTime.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_core/juce_core_zlib.c
)

target_compile_definitions(juce_core PUBLIC
        $<$<CONFIG:Debug>:DEBUG>
        $<$<CONFIG:Release>:NDEBUG>
        JUCE_GLOBAL_MODULE_SETTINGS_INCLUDED=1
        JUCE_UNIT_TESTS=0
#        JUCE_USE_FREETYPE=1
)

if (APPLE)
    target_compile_definitions(juce_core PUBLIC JUCE_MAC=1)
    target_link_libraries(juce_core PUBLIC
        "-framework Cocoa"
        "-framework Foundation"
        "-framework IOKit"
        "-framework Security"
        "-framework AudioToolbox"
        "-framework CoreAudio"
        "-framework CoreFoundation"
    )
endif()

checkBigObjOnWindows(juce_core)
