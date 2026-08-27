addJuceModule(juce_dsp)

target_link_libraries(juce_dsp
    PUBLIC
        juce_audio_formats
)

if (APPLE)
    target_link_libraries(juce_dsp
        PUBLIC
            "-framework Accelerate"
    )
endif()
