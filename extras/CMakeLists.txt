include(${JUCE_SOURCE_DIR}/extras/Build/CMake/JUCEModuleSupport.cmake)
include(${JUCE_SOURCE_DIR}/extras/Build/CMake/JUCEUtils.cmake)

install(DIRECTORY
    ${JUCE_SOURCE_DIR}/extras/Build/CMake
    DESTINATION extras/Build
    PATTERN "PIP*.cpp.in" EXCLUDE
)
