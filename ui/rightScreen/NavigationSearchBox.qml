import QtQuick
import QtQuick.Controls

Rectangle {
    id: navSearchBox
    radius: 5
    color: "#fafafa"


    Image {
        id: searchIcon
        source: "qrc:/ui/assets/search.png"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: parent.verticalCenter
        }
        height: parent.height * 0.4
        fillMode: Image.PreserveAspectFit
        opacity: 0.9
    }

    TextField {
        id: navigationTextInput
        placeholderText: "Navigation"
        font.pixelSize: 16
        color: "#373737"
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: searchIcon.right
            leftMargin: 20
            rightMargin: 20
        }

        background: Rectangle {
            color: "transparent"
            radius: 0
        }
    }

}
