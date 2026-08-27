include(FetchContent)


FetchContent_Declare(
        JUCE
        GIT_REPOSITORY  https://github.com/juce-framework/JUCE.git
        GIT_TAG         9.0.1
        GIT_PROGRESS    TRUE
)
FetchContent_MakeAvailable(JUCE)
