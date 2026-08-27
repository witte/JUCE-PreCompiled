addJuceModule(juce_audio_basics)

target_link_libraries(juce_audio_basics PUBLIC juce_core)

if (APPLE)
    target_link_libraries(juce_audio_basics PUBLIC
            "-framework Accelerate")
endif()
