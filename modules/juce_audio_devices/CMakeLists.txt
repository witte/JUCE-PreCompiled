addJuceModule(juce_audio_devices)

target_link_libraries(juce_audio_devices
    PUBLIC
        juce_audio_basics
        juce_events
)

if (APPLE)
    target_link_libraries(juce_audio_devices
        PUBLIC
            "-framework CoreAudio"
            "-framework CoreMIDI"
            "-framework AudioToolbox"
    )
endif()
