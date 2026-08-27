addJuceModule(juce_gui_extra)

target_compile_definitions(juce_gui_extra
    PUBLIC
        JUCE_WEBVIEW_INTEROP_LIBRARY_VERSION=\"1.0.0\"
)

target_link_libraries(juce_gui_extra
    PUBLIC
        juce_gui_basics
)

if (APPLE)
    target_link_libraries(juce_gui_extra
        PUBLIC
            "-framework WebKit"
    )
endif()
