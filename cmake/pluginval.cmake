set(PLUGINVAL_DIR "${CMAKE_BINARY_DIR}")

if (APPLE)
    set(PLUGINVAL_URL "https://github.com/Tracktion/pluginval/releases/latest/download/pluginval_macOS.zip")
    set(PLUGINVAL_EXE "pluginval.app/Contents/MacOS/pluginval")
elseif (WIN32)
    set(PLUGINVAL_URL "https://github.com/Tracktion/pluginval/releases/latest/download/pluginval_Windows.zip")
    set(PLUGINVAL_EXE "pluginval.exe")
else ()
    set(PLUGINVAL_URL "https://github.com/Tracktion/pluginval/releases/latest/download/pluginval_Linux.zip")
    set(PLUGINVAL_EXE "pluginval")
endif ()


message("Downloading pluginval> ${CMAKE_INSTALL_PREFIX}/bin")
set(PLUGINVAL_ZIP "${PLUGINVAL_DIR}/pluginval.zip")

file(DOWNLOAD ${PLUGINVAL_URL} ${PLUGINVAL_ZIP})
file(ARCHIVE_EXTRACT INPUT ${PLUGINVAL_ZIP} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)

set(pluginValPath "${CMAKE_INSTALL_PREFIX}/bin/${PLUGINVAL_EXE}")

if (NOT WIN32)
    set(PLUGINVAL_CHMOD_CMD chmod +x "${pluginValPath}")
else ()
    set(PLUGINVAL_CHMOD_CMD ${CMAKE_COMMAND} -E true) # no op on windows
endif ()

execute_process(
    COMMAND ${PLUGINVAL_CHMOD_CMD}
#    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    RESULT_VARIABLE result
    OUTPUT_VARIABLE output
    ERROR_VARIABLE error
)
