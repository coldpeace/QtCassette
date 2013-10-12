import QtQuick 2.0

PathView {
    id: pathView

    property int itemWidth: 400
    property int itemHeight: 400
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    focus: true
    interactive: true
    signal select(string album)
    property int index: 0
    property bool font: true

    delegate: Component {
            Image {
                id: image

                opacity: PathView.iconOpacity
                z: PathView.z
                scale: PathView.iconScale
                source: "./cassette-2-icon.png"
                anchors.bottomMargin: 15
                anchors.leftMargin: 50
                width: 300
                height: 300

                Text {
                    id: _title
                    text: title
                    font.family: app.appFont.name
                    visible: image.PathView.isCurrentItem ? 1 : 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 100
                    elide: Text.ElideRight

                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        select(path)
                    }
                }
            }
        }

    path: Path {startX: 0
        startY: parent.height / 2
        PathAttribute { name: "z"; value: 0 }  PathAttribute { name: "rotationAngle"; value: 60 }
        PathAttribute { name: "iconScale"; value: 0.5 }
        PathAttribute { name: "iconOpacity"; value: 0.5 }
        PathLine { x: parent.width / 2; y: parent.height / 2 }
        PathAttribute { name: "z"; value: 100 }
        PathAttribute { name: "rotationAngle"; value: 0 }
        PathAttribute { name: "iconScale"; value: 2 }
        PathAttribute { name: "iconOpacity"; value: 1 }
        PathLine { x: parent.width; y: parent.height / 2; }
        PathAttribute { name: "z"; value: 0 }
        PathAttribute { name: "rotationAngle"; value: -60 }
        PathAttribute { name: "iconScale"; value: 0.5 }
        PathAttribute { name: "iconOpacity"; value: 0.5 }
    }

}
