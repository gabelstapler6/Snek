#ifndef SNAKEBODY_H
#define SNAKEBODY_H

#include <QPoint>
#include <QObject>

class SnakeBody : public QObject
{

    Q_OBJECT

private:
    QPoint position;
    SnakeBody* next;

    void setPosition(QPoint pos);
public:
    SnakeBody(QObject* parent = nullptr);
    ~SnakeBody();

    Q_INVOKABLE void setNext(SnakeBody* next);
    Q_INVOKABLE SnakeBody* getNext();

    Q_INVOKABLE void move(int x, int y);
    Q_INVOKABLE bool moveAndCollide(int xNew, int yNew, int xColl, int yColl);
    Q_INVOKABLE void eat(SnakeBody* newTail);
    Q_INVOKABLE bool isCollision(int x, int y);

    Q_INVOKABLE QPoint getPosition();


signals:
    void positionChanged();

};


#endif // SNAKEBODY_H
