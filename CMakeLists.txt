cmake_minimum_required(VERSION 3.16)

project(infotainment VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Quick)


qt_add_executable(appinfotainment
    main.cpp
)

qt_add_qml_module(appinfotainment
    URI infotainment
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES ui/bottomBar/BottomBar.qml
        QML_FILES ui/rightScreen/RightScreen.qml
        QML_FILES ui/leftScreen/LeftScreen.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appinfotainment PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appinfotainment
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appinfotainment
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appinfotainment
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
