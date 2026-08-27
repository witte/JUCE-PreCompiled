addJuceModule(juce_graphics)

target_sources(juce_graphics
    PRIVATE
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_Harfbuzz.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_libjpg_1.c
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_libjpg_2.c
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_libjpg_3.c
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_libpng.c
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_lunasvg.c
        ${JUCE_SOURCE_DIR}/modules/juce_graphics/juce_graphics_Sheenbidi.c
)

target_link_libraries(juce_graphics PUBLIC juce_events)

if (APPLE)
    target_link_libraries(juce_graphics PUBLIC
            "-framework Cocoa"
            "-framework QuartzCore")
endif()
