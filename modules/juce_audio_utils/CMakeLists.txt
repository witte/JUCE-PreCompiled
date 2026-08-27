addJuceModule(juce_audio_utils)

target_compile_definitions(juce_audio_utils
    PUBLIC
        JUCE_MODULE_AVAILABLE_juce_audio_utils=1
)

target_link_libraries(juce_audio_utils
    PUBLIC
        juce_audio_processors
        juce_audio_formats
        juce_audio_devices
)

if (APPLE)
    target_link_libraries(juce_audio_utils
        PUBLIC
            "-framework CoreAudioKit"
            "-framework DiscRecording"
    )
endif()
