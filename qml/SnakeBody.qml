import QtQuick 2.15

import SnakeBodyModel 1.0


Item {
    id: snekBody

    property string direction: "UP" // DOWN, LEFT, RIGHT
    
    property int size: 20

    property alias model: model
    property alias rect: rect

    Rectangle {
        id: rect
        x: parent.x
        y: parent.y
        width: size
        height: size
        color: "white"
    }

    SnakeBodyModel {
        id: model
    }

    Connections {
        target: model
        function onPositionChanged() {
            let pos = model.getPosition()
            x = pos.x
            y = pos.y
            
            if(y < 0 || y >= snekRoot.height/2 || x < 0 || x >= snekRoot.width/2){
                snekRoot.gameOver()
            }
        }
    }

    function move(){
        let xNew, yNew
        switch(direction){
            case "UP":
                xNew = x
                yNew = y - size / 2
                break
            case "DOWN":
                xNew = x
                yNew = y + size / 2
                break
            case "LEFT":
                xNew = x - size / 2
                yNew = y
                break
            case "RIGHT":
                xNew = x + size / 2
                yNew = y
                break
        }

        model.move(xNew, yNew)

    }
    
}