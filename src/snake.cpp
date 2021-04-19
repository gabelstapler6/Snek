#include "snake.h"

Snake::Snake(QObject* parent) :
    QObject(parent),
    head(new SnakeBody()),
    tail(head)
{

}

Snake::~Snake()
{
    SnakeBody* helper = head;
    while (helper != nullptr)
    {
        SnakeBody* del = helper;
        helper = helper->getNext();
        delete del;
    }
}

void Snake::eat(SnakeBody* body)
{
    tail->setNext(body);
    tail = body;
}

void Snake::updateHeadPosition(QPoint pos)
{
    QPoint oldPos = head->getPosition();
    head->setPosition(pos);

    SnakeBody* helper = head;
    helper = helper->getNext();

    while (helper != nullptr)
    {
        helper->setPosition(oldPos);
        oldPos = helper->getPosition();
        helper = helper->getNext();
    }
}