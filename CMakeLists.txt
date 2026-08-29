cmake_minimum_required(VERSION 4.4.0)
project(JUCE-PreCompiled VERSION 9.0.1 LANGUAGES C CXX)

if (APPLE)
    enable_language(OBJC OBJCXX)
endif()


set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")
#set(CMAKE_OSX_DEPLOYMENT_TARGET 10.15)
set(CMAKE_OSX_DEPLOYMENT_TARGET 26.0.0)

# add_compile_options(-fsanitize=address)
# add_link_options(-fsanitize=address)
# add_link_options(-fsanitize=thread)

include(cmake/Utils.cmake)


set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/__install)
set(JUCE_VERSION 9.0.1)

include(FetchContent)
FetchContent_Declare(
        JUCE
        URL  https://github.com/juce-framework/JUCE/archive/refs/tags/${JUCE_VERSION}.tar.gz
        SOURCE_SUBDIR __JUCE-src
)
FetchContent_MakeAvailable(JUCE)

FetchContent_GetProperties(JUCE SOURCE_DIR JUCE_SOURCE_DIR)
set(JUCE_BINARY_DIR ${CMAKE_BINARY_DIR}/JUCE)



add_subdirectory(${JUCE_SOURCE_DIR}/extras/Build/juceaide)
add_subdirectory(extras)
add_subdirectory(modules/juce_core)
add_subdirectory(modules/juce_events)
add_subdirectory(modules/juce_data_structures)
add_subdirectory(modules/juce_audio_basics)
add_subdirectory(modules/juce_audio_processors_headless)
add_subdirectory(modules/juce_graphics)
add_subdirectory(modules/juce_gui_basics)
add_subdirectory(modules/juce_gui_extra)
add_subdirectory(modules/juce_audio_processors)
add_subdirectory(modules/juce_audio_formats)
add_subdirectory(modules/juce_audio_devices)
add_subdirectory(modules/juce_audio_utils)
add_subdirectory(modules/juce_dsp)
add_subdirectory(modules/juce_audio_plugin_client)


setupImportedTarget(juce_core)
setupImportedTarget(juce_events)
setupImportedTarget(juce_data_structures)
setupImportedTarget(juce_audio_basics)
#setupImportedTarget(juce_audio_processors_headless)
install(TARGETS juce_audio_processors_headless FILE_SET HEADERS)
setupImportedTarget(juce_graphics)
setupImportedTarget(juce_gui_basics)
setupImportedTarget(juce_gui_extra)
setupImportedTarget(juce_audio_processors)
setupImportedTarget(juce_audio_formats)
setupImportedTarget(juce_audio_devices)
setupImportedTarget(juce_audio_utils)
setupImportedTarget(juce_dsp)
#setupImportedTarget(juce_audio_plugin_client)


include(cmake/pluginval.cmake)

configure_file(
    cmake/pluginval.cmake.in
    ${CMAKE_INSTALL_PREFIX}/share/pluginval.cmake
    @ONLY
)

if (APPLE)
    configure_file(
        cmake/auval.cmake
        ${CMAKE_INSTALL_PREFIX}/share/auval.cmake
        @ONLY
    )
endif()

configure_file(
    cmake/CMakeListsImported.txt.in
    ${CMAKE_INSTALL_PREFIX}/CMakeLists.txt
    @ONLY
)


set(ARCHIVE_PATH "${CMAKE_BINARY_DIR}/__package/${PROJECT_NAME}-${PROJECT_VERSION}-${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_HOST_SYSTEM_PROCESSOR}-${CMAKE_BUILD_TYPE}.tar.gz")
add_custom_target(package
    COMMAND ${CMAKE_COMMAND} --install .
    COMMAND echo "Generating .tar.gz ${ARCHIVE_PATH}"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/__package"
    COMMAND ${CMAKE_COMMAND} -E tar cfz ${ARCHIVE_PATH} --format=gnutar ${CMAKE_INSTALL_PREFIX}
    USES_TERMINAL
)
