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
    title: qsTr("Snek")
    color: "black"

    property var head: snek
    property var food: null
    property var snake: [snek]


    Button {
        id: button
        z:1
        anchors.centerIn: parent
        
        height: 35
        width: 75

        text: isStart ? "start" : "restart"
        
        property bool isStart: true
        

        onClicked: {
            if(!isStart){
                for(let i = 1; i < snake.length; i++){
                    snake[i].destroy()
                }
                snake = []
                snake.push(snek)
                snek.rect.color = "white"
                snek.model.setNext(null)
                snek.x = 90
                snek.y = 90
            }
            snek.visible = true
            moveTimer.running = true
            visible = false
            isStart = false
            keyboardInput.focus = true
            spawnFood()
        }
        
    }

    SnakeBody {
        id: snek
        x: 90
        y: 90
        visible: false

        onXChanged: {
            checkCollision()
        }
        onYChanged: {
            checkCollision()
        }

        function checkCollision(){
            
            var next = model.getNext()
            if(next != null){
                if(next.isCollision(x, y)){
                    gameOver()
                }
            }

            if(x == food.x/2 && y == food.y/2){
                eat()
            }
        }

        function eat() {
            let comp = Qt.createComponent("SnakeBody.qml")
            var newTail = comp.createObject(root)
            model.eat(newTail.model)
            spawnFood()

            snake.push(newTail)
        }

    }

    Timer {
        id: moveTimer
        repeat: true
        interval: 250
        
        onTriggered: {
            head.move()
        }
    }
        
    Item {
        id: keyboardInput
        focus: true
        
        Keys.onRightPressed: {
            head.direction = "RIGHT"
        }

        Keys.onLeftPressed: {
            head.direction = "LEFT"
        }

        Keys.onUpPressed: {
            head.direction = "UP"
        }

        Keys.onDownPressed: {
            head.direction = "DOWN"
        }
    }


    function spawnFood(){
        let xPos = getRandomInt(0, 380)
        while(xPos % 20 != 0){
            xPos = getRandomInt(0, 380)
        }
        let yPos = getRandomInt(0, 380)
        while(yPos % 20 != 0){
            yPos = getRandomInt(0, 380)
        }
        if(food == null){
            let comp = Qt.createComponent("Food.qml")
            food = comp.createObject(root, {x: xPos, y: yPos})
        } else {
            food.x = xPos
            food.y = yPos
        }
    }
    
    function gameOver() {
        for(let i = 0; i < snake.length; i++){
            snake[i].rect.color = "red"
        }
        moveTimer.running = false
        button.visible = true
    }

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * max) + min;
    }

}
