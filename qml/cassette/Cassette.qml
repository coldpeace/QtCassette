import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: root

    color: "transparent"
    property bool flag: true
    property bool inject: false
    property int index: 0
    property int size: 0
    property string currentAlbum
    signal back()

    function setSongList(album) {
        songList.clear();
        index = 0;
        currentAlbum = album.split("/").pop(-1);
        console.log(album);
        var list = mediaBackend.songList(album);
        size = list.length;
        for (var i = 0; i < size; i++) {
            songList.append({title: list[i].split("/").pop(-1), path: list[i]});
        }
        setSong();
    }

    function setSong() {
        audio.source = songList.get(index%size).path;
        songTitle.text = songList.get(index%size).title;
    }

    ListModel {
        id: songList
    }

    Audio {
        id: audio
    }

    Image {
        id: cassette
        source: "cassette.png"
        anchors.fill: parent
        scale: 1.05

        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }

        Image {
            anchors.top : parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            source: "photo_paper.png"

            Text {
                id: songTitle
                anchors.centerIn: parent
                font.family: app.appFont.name

                Behavior on text {
                    SequentialAnimation {
                        id: titleAnim
                        running: false

                        ParallelAnimation {
                            NumberAnimation { target: songTitle; property: "scale"; to: 1.5; duration: 200}
                            NumberAnimation { target: songTitle; property: "opacity"; to: 0; duration: 200}
                        }

                        ParallelAnimation {
                            NumberAnimation { target: songTitle; property: "scale"; to: 1; duration: 200}
                            NumberAnimation { target: songTitle; property: "opacity"; to: 1; duration: 200}
                        }
                    }
                }

                }
            }
    }


    Image {
        id: axeLeft
        width: 150
        height: 150
        x: 302
        y: 275
        source: "axe.png"
        opacity: cassette.opacity
        visible: cassette.visible
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }

    Image {
        id: axeRight
        width: 150
        height: 150
        x: 795
        y: 275
        source: "axe.png"
        opacity: cassette.opacity
        visible: cassette.visible
        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }
    }

    MouseArea {
        anchors.fill: parent
        property int initialX
        property bool swiped: false

        onPressed: {
            initialX = mouseX
        }

        onReleased: {
            var diff = initialX - mouseX;
            if (diff > 200) {
                swiped = true
                index++;
                setSong();
//                titleAnim.start();
                if (flag)
                    audio.play();
            }
            else if (diff < -200) {
                swiped = true
                index--;
                setSong();
//                titleAnim.start();
                if (flag)
                    audio.play();
            }
        }

        onClicked: {
            if (!swiped) {
                if (songList.length !== 0) {
                    flag? audio.play() : audio.pause();
                    flag? anim.start() : anim.stop()
                    flag = !flag
                }
            }
            else {
                swiped = false;
            }
        }

        onPressAndHold: {
            inject? injectAnim.start() : rejectAnim.start()
            inject = !inject
        }
    }

    Rectangle {
        id: backArea
        color: "transparent"
        width: 120
        height: 100
        x: 1050
        y: 550

        MouseArea {
            anchors.fill: parent
            onClicked: back();
        }
    }
    ParallelAnimation {
        id: anim
        running: false
        NumberAnimation { target: axeLeft; property: "rotation"; to: 360; duration: 5000; loops: -1}
        NumberAnimation { target: axeRight; property: "rotation"; to: 360; duration: 5000; loops: -1}
    }

    ParallelAnimation {
        id: injectAnim
        running: false
        NumberAnimation { target: cassette; property: "scale"; to: 1.05; duration: 200; easing: Easing.InCurve}
    }

    ParallelAnimation {
        id: rejectAnim
        running: false
        NumberAnimation { target: cassette; property: "scale"; to: 1; duration: 200; easing: Easing.OutCurve}
    }

}
