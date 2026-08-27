addJuceModule(juce_audio_processors_headless)

target_sources(juce_audio_processors_headless
    PRIVATE
        ${JUCE_SOURCE_DIR}/modules/juce_audio_processors_headless/juce_audio_processors_headless_ara.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_audio_processors_headless/juce_audio_processors_headless_lv2_libs.cpp
)

target_include_directories(juce_audio_processors_headless
    PUBLIC
        ${JUCE_SOURCE_DIR}/modules/juce_audio_processors_headless/format_types/VST3_SDK
)

target_link_libraries(juce_audio_processors_headless
    PUBLIC
        juce_events juce_audio_basics
)

if (APPLE)
    target_link_libraries(juce_audio_processors_headless
        PUBLIC
            "-framework CoreAudio"
            "-framework CoreMIDI"
            "-framework AudioToolbox"
    )
endif()

checkBigObjOnWindows(juce_audio_processors_headless)

install(
    DIRECTORY
        ${JUCE_SOURCE_DIR}/modules/juce_audio_processors_headless/format_types/VST3_SDK
    DESTINATION
        include/juce_audio_processors_headless/format_types
)
