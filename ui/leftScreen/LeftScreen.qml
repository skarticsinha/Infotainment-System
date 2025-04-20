import QtQuick 2.15

Rectangle {
    id: leftScreen

    anchors {
        left: parent.left
        right: rightScreen.left
        bottom: bottomBar.top
        top: parent.top
    }
    color: "#f5f5f5"

    Image {
        id: carRender
        source: "qrc:/ui/assets/car_render.jpeg"
        anchors.centerIn: parent
        width: parent.width * 1.1
        fillMode: Image.PreserveAspectFit
    }
}
