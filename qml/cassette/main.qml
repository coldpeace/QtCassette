import QtQuick 2.0

Rectangle {
    id: app
    property alias appFont: handfont

    width: 800
    height: 500
    property bool flag: true

    FontLoader { id: handfont; source: "GochiHand-Regular.ttf" }

    Image {
        id: backgournd

        anchors.fill: parent
        source: "metalic.png"
    }

    function switchMenu() {

        anim.start();
        if (flag) {
            cassette.x = 0
        } else {
            cassette.x = cassette.width
        }

        flag = !flag;
    }

    ListModel {
        id: albumModel
    }

    PathAlbumList {
        id: albumPath
        anchors.fill: parent
        model: albumModel

        onSelect: {
            switchMenu();
            cassette.setSongList(album)
        }
    }

    Cassette {
        id: cassette

        x: width
        height: parent.height
        width: parent.width

        onBack:
        {
            switchMenu();

        }
        Behavior on x {
            NumberAnimation { duration: 500 }
        }
    }

    ParallelAnimation {
        id: anim
        running: false
        NumberAnimation { target: albumPath; property: "scale"; to: flag? 0 : 1; duration: 500; easing.type: Easing.InOutQuad }
        NumberAnimation { target: albumPath; property: "opacity"; to: flag ? 0 : 1; duration: 500; easing.type: Easing.InOutQuad }
    }

    Component.onCompleted: {
        console.log("on Completed...");
        var albumlist = mediaBackend.albumList();
        for (var i = 0; i < albumlist.length; i++) {
            console.log("Yes...");
            console.log(albumlist[i])
            albumModel.append({index: i, path: albumlist[i], title: albumlist[i].split("/").pop(-1)})

        }
    }
}
