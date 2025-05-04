import QtQuick 2.15

Rectangle {
    id: bottomBar
    anchors {
       left: parent.left
        right: parent.right
        bottom: parent.bottom
    }
    color: "black"
    height: parent.height / 12

    Image {
        id: carSettingsIcon
        source: "qrc:/ui/assets/electric-car.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height * 0.70
        anchors {
            left: parent.left
            leftMargin: 30
            verticalCenter: parent.verticalCenter
        }
    }
}

