import QtQuick 2.15

import SnakeBodyModel 1.0


Item {
    id: snekBody

    property string direction: "UP" // DOWN, LEFT, RIGHT
    
    property int size: 20

    property alias model: model

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
            print("x: " + x + " y: " + y)
            
            if(y < 0 || y >= root.height/2 || x < 0 || x >= root.width/2){
                root.gameOver()
            }
        }
    }

    function move(){
        switch(direction){
            case "UP":
                model.move(x, y - size/2)
                break
            case "DOWN":
                model.move(x, y + size/2)
                break
            case "LEFT":
                model.move(x - size/2, y)
                break
            case "RIGHT":
                model.move(x + size/2, y)
                break
        }
    }
    
}