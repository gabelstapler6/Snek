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

public:
    SnakeBody(QObject* parent = nullptr);
    ~SnakeBody();

    Q_INVOKABLE void setNext(SnakeBody* next);
    SnakeBody* getNext();

    Q_INVOKABLE void move(int x, int y);
    Q_INVOKABLE bool isCollision(int x, int y);

    void setPosition(QPoint pos);
    QPoint getPosition();

signals:
    void positionChanged();

};


#endif // SNAKEBODY_H
