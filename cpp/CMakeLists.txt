CMAKE_MINIMUM_REQUIRED(VERSION 3.12)

PROJECT(myApp)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(Qt5Widgets PATHS ../../../lib/Qt5.12.0/5.12.0/clang_64)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

#-----------------------------------------------------------------------------------------------------------------------
# macOS app bundle settings

if (APPLE)
    # Location for the info.plist template
    set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/resources/macOS")
    # app icon
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
    add_executable(myApp MACOSX_BUNDLE ${ICNS_FILE_PATH} ${SOURCES})
else ()
    add_executable(myApp ${SOURCES})
endif ()

target_link_libraries(myApp Qt5::Widgets)
