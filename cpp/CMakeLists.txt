CMAKE_MINIMUM_REQUIRED(VERSION 3.12)

PROJECT(myApp)
set(APP_NAME myApp)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5Widgets PATHS $ENV{QT_LIBRARY_PATH})

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

#-----------------------------------------------------------------------------------------------------------------------
# macOS app bundle settings
if (APPLE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 10.13)

    set(APP_BUNDLE_PATH ${CMAKE_CURRENT_BINARY_DIR}/${APP_NAME}.app)

    # Set the location of the info.plist template
    set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/resources/macOS")

    # Set the source and destination location of the app icon
    set(ICNS_FILE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/resources/macOS/icon.icns")
    set_source_files_properties(${ICNS_FILE_PATH} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
endif ()

#-----------------------------------------------------------------------------------------------------------------------
# sources

set(SOURCES
        src/main.cpp
        src/myapp.cpp
        src/mainwindow.cpp
        )

#-----------------------------------------------------------------------------------------------------------------------
# compiling and linking

if (APPLE)
    add_executable(${APP_NAME} MACOSX_BUNDLE ${ICNS_FILE_PATH} ${SOURCES})
else ()
    add_executable(${APP_NAME} ${SOURCES})
endif ()

target_link_libraries(${APP_NAME} Qt5::Widgets)

#-----------------------------------------------------------------------------------------------------------------------
# post installation

if (APPLE)
    add_custom_command(TARGET ${APP_NAME} POST_BUILD COMMAND macdeployqt ARGS ${APP_BUNDLE_PATH})

    # Do code signing when building Release only, not for Debug mode.
    if (CMAKE_BUILD_TYPE MATCHES Release)
        add_custom_command(TARGET ${APP_NAME} POST_BUILD
                COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/resources/macOS/post_build_codesign.sh ARGS ${APP_BUNDLE_PATH})
    endif ()
endif ()

