import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

Window {
    id: window
    width: 1140
    height: 635
    color: "#d6b6d0"
    visible: true
    title: qsTr("CMPT 365 Project 9000!! with X-POWERRR!!!")

    RoundButton {
        id: selectVidBtn
        x: 458
        y: 15
        radius: 4
        width: 138
        height: 40
        text: "Select Video File"
        anchors.right: parent.right
        anchors.rightMargin: 544
        onClicked: openDialog.open()
    }

    FileDialog {
        id: openDialog
        title: "Please choose a video file"
        nameFilters: ["Video files (*.mp4 *.mpeg *.avi)"]
        folder: shortcuts.home
        modality: Qt.NonModal
        selectExisting: true
        selectFolder: false
        selectMultiple: false
        onAccepted: {
            var path = openDialog.fileUrl.toString()
            path = path.replace(/^(file:\/{2})/,"")
            var cleanPath = decodeURIComponent(path)
            console.log(cleanPath)
            filePathDisplay.text = cleanPath
            // call the videoobject initializer
            openDialog.close()
        }
        onRejected: {
            console.log("Canceled")
            openDialog.close()
        }
    }

    TextField {
        id: filePathDisplay
        x: 18
        y: 15
        width: 434
        height: 40
        placeholderText: qsTr("Path")
        enabled: false
    }

    GroupBox {
        id: displayBox
        x: 0
        y: 247
        width: 596
        height: 388
        title: qsTr("")

        Image {
            id: stiDisplay
            x: 0
            y: 45
            width: 584
            height: 258
            fillMode: Image.PreserveAspectFit
        }

        RoundButton{
            id: thresholdBtn
            x: 217
            y: 5
            radius: 4
            width: 138
            height: 34
            text: "Threshold"
        }
        RoundButton{
            id: previousBtn
            x: 89
            y: 5
            radius: 10
            width: 92
            height: 34
            text: "<"
        }
        RoundButton{
            id: nextBtn
            x: 397
            y: 5
            radius: 10
            width: 92
            height: 34
            text: ">"
        }
        RoundButton{
            id: saveBtn
            x: 0
            y: 309
            radius: 4
            width: 138
            height: 40
            text: "Save"
        }
    }

    GroupBox {
        id: radioBox
        x: 18
        y: 83
        width: 578
        height: 144
        title: "Select a STI creation method and hit \"Analyze\""

        RadioButton {
            id: radio0
            width: 180
            height: 40
            text: qsTr("Copy Pixel - Col")
            checked:true
        }

        RadioButton {
            id: radio1
            x: 0
            y: 57
            width: 180
            text: qsTr("Copy Pixel - Row")
        }

        RadioButton {
            id: radio2
            x: 209
            y: 0
            text: qsTr("Histogram Diff - Col")
        }

        RadioButton {
            id: radio3
            x: 207
            y: 58
            width: 188
            text: qsTr("Histogram Diff - Row")
        }

        RoundButton {
            id: beginAnalysisBtn
            x: 428
            y: 0
            radius: 4
            width: 138
            height: 40
            text: "Analyze"
            anchors.right: parent.right
            //            anchors.rightMargin: -12
            onClicked: console.log("temp")// call cpp method
        }

    }

    Rectangle {
        id: rectangle
        x: 696
        y: 32
        width: 1
        height: 572
        color: "#888888"
        transformOrigin: Item.Center
    }

    TextArea {
        id: textArea
        x: 708
        y: 21
        width: 420
        height: 277
        placeholderText: qsTr("Text Area")
    }






}
