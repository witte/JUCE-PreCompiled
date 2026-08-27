addJuceModule(juce_audio_formats)

target_sources(juce_audio_formats
    PRIVATE
        ${JUCE_SOURCE_DIR}/modules/juce_audio_formats/juce_audio_formats_flac_1.c
        ${JUCE_SOURCE_DIR}/modules/juce_audio_formats/juce_audio_formats_flac_2.c
)

target_link_libraries(juce_audio_formats
    PUBLIC
        juce_audio_basics
)

if (APPLE)
    target_link_libraries(juce_audio_formats
        PUBLIC
            "-framework CoreAudio"
            "-framework CoreMIDI"
            "-framework QuartzCore"
            "-framework AudioToolbox"
    )
endif()
