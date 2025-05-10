import QtQuick
import QtQuick.Controls
import "ui/bottomBar"
import "ui/rightScreen"
import "ui/leftScreen"

Window {
    width: 1280
    height: 720
    visible: true
    title: qsTr("Infotainment System")

    LeftScreen {
        id: leftScreen
    }

    RightScreen {
        id: rightScreen
    }

    BottomBar {
        id: bottomBar
    }

}
