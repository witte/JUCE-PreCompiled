addJuceModule(juce_audio_processors)

target_link_libraries(juce_audio_processors
    PUBLIC
        juce_gui_extra
        juce_audio_processors_headless
)

checkBigObjOnWindows(juce_audio_processors)
