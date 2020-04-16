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
        id: roundButton
        x: 135
        y: 63
        width: 111
        height: 40
        text: "Select Video File"
        onClicked: openDialog.open()
    }

    FileDialog {
        id: openDialog
        title: "Please choose a video file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
        Component.onCompleted: visible = true
    }

}
