#include "snakebody.h"

SnakeBody::SnakeBody(QObject* parent) : 
    QObject(parent),
    next(nullptr)
{
}

SnakeBody::~SnakeBody()
{
}

void SnakeBody::setNext(SnakeBody* next)
{
    this->next = next;
}

SnakeBody* SnakeBody::getNext()
{
    return next;
}

void SnakeBody::move(int x, int y)
{
    QPoint oldPos = position;
    setPosition(QPoint(x, y));

    if(next != nullptr)
        next->move(oldPos.x(), oldPos.y());
}

bool SnakeBody::moveAndCollide(int xNew, int yNew, int xColl, int yColl){
    QPoint oldPos = position;
    setPosition(QPoint(xNew, yNew));

    if(oldPos.x() == xColl && oldPos.y() == yColl){
        return true;
    }
    
    if(next != nullptr){
        return next->moveAndCollide(oldPos.x(), oldPos.y(), xColl, yColl);
    } else {
        return false;
    }
}

void SnakeBody::eat(SnakeBody* newTail)
{
    if(next == nullptr){
        next = newTail;
        newTail->setPosition(position);
    } else {
        next->eat(newTail);
    }
}

bool SnakeBody::isCollision(int x, int y)
{
    if(position.x() == x && position.y() == y){
        return true;
    } else {
        if(next != nullptr){
            return next->isCollision(x, y);
        } else {
            return false;
        }
    }
}

void SnakeBody::setPosition(QPoint pos)
{
    position = pos;
    emit positionChanged();
}

QPoint SnakeBody::getPosition()
{
    return position;
}
