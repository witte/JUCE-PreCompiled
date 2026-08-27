addJuceModule(juce_gui_basics)

target_sources(juce_gui_basics
    PRIVATE
        ${JUCE_SOURCE_DIR}/modules/juce_gui_basics/juce_gui_basics_2.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_gui_basics/juce_gui_basics_3.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_gui_basics/juce_gui_basics_4.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_gui_basics/juce_gui_basics_5.cpp
)

target_link_libraries(juce_gui_basics
    PUBLIC
        juce_graphics
        juce_data_structures
)

if (APPLE)
    target_link_libraries(juce_gui_basics PUBLIC
            "-framework Cocoa"
            "-framework QuartzCore"
            "-framework Metal"
            "-framework MetalKit"
    )
endif()
