import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtGraphicalEffects 1.15

Window {
    id: root
    property var size: 500
    width: size
    height: size
    maximumHeight: size
    maximumWidth: size
    minimumHeight: size
    minimumWidth: size

    flags: Qt.FramelessWindowHint

    visible: true
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: menu.state = 'closed'
    }

    
    DropShadow {
        id: shadow
        anchors.fill: bg
        color: "black"
        samples: 16
        radius: 12
        source: bg
    }

    DragHandler {
        target: topBar
    }
    
    
    Rectangle {
        id: bg
        anchors.fill: parent
        anchors.margins: 6
        
        color: "gray"
        
        Rectangle {
            id: topBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: 40

            color: "lightgray"

            Button {
                id: closeButton
                anchors.top: parent.top
                anchors.right: parent.right
                height: 40
                width: 40
                text: "X"
                onClicked: {
                    root.close()
                }

            }

            Button {
                id: minimizeButton
                anchors.top: parent.top
                anchors.right: closeButton.left
                height: 40
                width: 40
                text: "_"
            }

        }

        Snek {
            id: snekGame
            
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenterOffset: 20
            anchors.verticalCenterOffset: 20

            MouseArea {
                anchors.fill: parent
                onClicked: menu.state = 'closed'
            }

            onStartGame: {
                menu.state = 'closed'
            }
        }

        Rectangle {
            id: menu
            anchors.left: parent.left
            anchors.top: topBar.bottom
            anchors.bottom: parent.bottom
            color: "darkgray"

            state: 'closed'

            states: [
                State {
                    name: 'opened'
                    PropertyChanges {
                        target: menu
                        width: 240
                    }
                },

                State {
                    name: 'closed'
                    PropertyChanges {
                        target: menu
                        width: 40
                    }
                }
            ]

            transitions: Transition {
                PropertyAnimation {
                    property: "width"
                    easing.type: Easing.InOutQuad
                }
            }

            Button {
                id: menuButton
                anchors.left: parent.left
                anchors.top: parent.top2
                height: 40
                width: 40
                text: "="

                onClicked: {
                    if (menu.state == 'closed') {
                        menu.state = 'opened'
                    } else {
                        menu.state = 'closed'
                    }
                }
            }
        }
    }
}
