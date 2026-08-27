# In JUCE/Extras/Build/CMake/JUCEUtils.cmake the '_juce_link_plugin_wrapper'
# function makes any plugin created with 'juce_add_plugin' link to these. I didn't want to mess with internal
# JUCE code, so declaring these targets is a way to keep things working
add_library(juce_audio_plugin_client INTERFACE)
set_target_properties(juce_audio_plugin_client
    PROPERTIES
        INTERFACE_JUCE_MODULE_PATH "${JUCE_SOURCE_DIR}/modules")
add_library(juce::juce_audio_plugin_client ALIAS juce_audio_plugin_client)


# TODO: see if these are really needed here (I think we only need them in the final compiled and zipped version,
#       the one that will be FetchContent'ed by the plugin)
add_library(juce_audio_plugin_client_Standalone INTERFACE)
add_library(juce::juce_audio_plugin_client_Standalone ALIAS juce_audio_plugin_client_Standalone)

add_library(juce_audio_plugin_client_VST3 INTERFACE)
add_library(juce::juce_audio_plugin_client_VST3 ALIAS juce_audio_plugin_client_VST3)

add_library(juce_audio_plugin_client_AU INTERFACE)
add_library(juce::juce_audio_plugin_client_AU ALIAS juce_audio_plugin_client_AU)


# TODO: specially not sure about this approach here, I think we could use the target_sources thing
install(
    DIRECTORY
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/AU
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/detail
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/Standalone
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/VST3
    DESTINATION
        include/juce_audio_plugin_client
)

install(
    FILES
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/juce_audio_plugin_client.h
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/juce_audio_plugin_client_AU_1.mm
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/juce_audio_plugin_client_AU_2.mm
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/juce_audio_plugin_client_VST3.cpp
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/juce_audio_plugin_client_VST3.mm
        ${JUCE_SOURCE_DIR}/modules/juce_audio_plugin_client/juce_audio_plugin_client_Standalone.cpp
    DESTINATION
        include/juce_audio_plugin_client
)
