import QtQuick
import QtLocation 6.5
import QtPositioning

Rectangle {
    id: rightscreen

    anchors {
        top: parent.top
        right: parent.right
        bottom: bottomBar.top
    }
    width: parent.width * 2/3
    // color: "orange"

    Plugin {
        id: mapPlugin
        name: "osm"
        PluginParameter {
            name: "osm.mapping.providersrepository.address"
            value: "http://a.tile.thunderforest.com"
        }
        PluginParameter {
            name: "osm.mapping.custom.host"
            value: "http://a.tile.thunderforest.com"
        }
        PluginParameter {
            name: "osm.mapping.custom.useragent"
            value: "infotainment"
        }
        PluginParameter {
            name: "osm.mapping.custom.apikey"
            value: "fc0fe8868a184be291cc763cfab82cd3"
        }
        PluginParameter {
            name: "osm.mapping.custom.maptype"
            value: "transport" // or "cycle", "outdoors", "landscape", etc.
        }
    }

    Map
    {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(20.220584, 85.735992) // CGU Bhubaneshwar
        zoomLevel: 18
        property geoCoordinate startCentroid

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
            }
            onScaleChanged: (delta) => {
                map.zoomLevel += Math.log2(delta)
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            onRotationChanged: (delta) => {
                map.bearing -= delta
                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
            }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
    }


    Image {
        id: lockIcon
        source: ( systemHandler.carLocked ? "qrc:/ui/assets/lock.png" : "qrc:/ui/assets/unlock.png")
        anchors {
            left: parent.left
            top: parent.top
            margins: 10
        }
        width: parent.width / 46
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            onClicked: systemHandler.setCarLocked( !systemHandler.carLocked )
        }
    }

    Text {
        id: dateTimeDisplay
        text: systemHandler.currentTime
        anchors {
            left: lockIcon.right
            leftMargin: 30
            bottom: lockIcon.bottom
        }
        font.pixelSize: 12
        font.weight: 500
        color: "black"
    }

    Text {
        id: outdoorTempratureDisplay
        text: systemHandler.outdoorTemp + "°F"
        anchors {
            left: dateTimeDisplay.right
            leftMargin: 30
            bottom: lockIcon.bottom
        }
        font.pixelSize: 12
        font.weight: 500
        color: "black"
    }

    Image {
        id: userIcon
        source: "qrc:/ui/assets/user.png"
        anchors {
            left: outdoorTempratureDisplay.right
            // bottom: lockIcon.bottom
            top: parent.top
            margins: 10
            leftMargin: 30
        }
        width: parent.width / 46
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: userName
        text: systemHandler.userName
        anchors {
            left: userIcon.right
            leftMargin: 5
            bottom: lockIcon.bottom
        }
        font.pixelSize: 12
        font.weight: 500
        color: "black"
    }

    NavigationSearchBox {
        id: navSearchBox
        anchors {
            left: lockIcon.left
            top: lockIcon.bottom
            topMargin: 15
        }
        width: parent.width * 1/3
        height: parent.height * 1/14
    }


}
