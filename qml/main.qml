import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    id: root

    property int size: 400

    width: size
    height: size
    maximumHeight: size
    maximumWidth: size
    minimumHeight: size
    minimumWidth: size

    visible: true
    title: qsTr("Hello World")
    color: "black"

    property var head: snek
    property var food: null

    Button {
        id: startButton
        
        anchors.left: parent.left
        anchors.top: parent.top
        
        height: 35
        width: 75

        text: "start"

        onClicked: {
            moveTimer.running = true
            visible = false
            keyboardInput.focus = true
            spawnFood()
        }
        
    }

    SnakeBody {
        id: snek
        x: 90
        y: 90
        
        onXChanged: {
            checkCollision()
        }
        onYChanged: {
            checkCollision()
        }

        function checkCollision(){
            if(model.isCollision(x, y)){
                gameOver()
            }

            if(x == food.x && y == food.y){
                // eat()
            }
        }
    }

    Timer {
        id: moveTimer
        repeat: true
        interval: 1000
        
        onTriggered: {
            head.move()
        }
    }
        
    Item {
        id: keyboardInput
        focus: true
        
        Keys.onRightPressed: {
            head.direction = "RIGHT"
            console.log(head.direction)
        }

        Keys.onLeftPressed: {
            head.direction = "LEFT"
            console.log(head.direction)

        }

        Keys.onUpPressed: {
            head.direction = "UP"
            console.log(head.direction)

        }

        Keys.onDownPressed: {
            head.direction = "DOWN"
            console.log(head.direction)

        }
    }


    function spawnFood(){
        let xPos = getRandomInt(0, 190)
        while(xPos % 20 != 0){
            xPos = getRandomInt(0, 190)
        }
        let yPos = getRandomInt(0, 190)
        while(yPos % 20 != 0){
            yPos = getRandomInt(0, 190)
        }
        
        let comp = Qt.createComponent("Food.qml")
        food = comp.createObject(root, {x: xPos, y: yPos})
    }
    
    function gameOver() {
        
        console.log("game over")

        moveTimer.running = false
        
    }

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * max) + min;
    }

}
