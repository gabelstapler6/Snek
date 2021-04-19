#ifndef SNAKE_H
#define SNAKE_H

# include <QObject>

#include "snakebody.h"


class Snake : public QObject
{
    Q_OBJECT

private:
    SnakeBody* head;
    SnakeBody* tail;

public:
    Snake(QObject* parent = nullptr);
    ~Snake();

    Q_INVOKABLE void eat(SnakeBody*);
    Q_INVOKABLE void updateHeadPosition(QPoint pos);
};

#endif // SNAKE_H
