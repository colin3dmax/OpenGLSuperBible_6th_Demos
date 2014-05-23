//
//  main.m
//  DemoGL
//
//  Created by colin3dmax on 14-5-23.
//  Copyright (c) 2014年 colin3dmax. All rights reserved.
//

#include "sb6.h"
#include <Foundation/Foundation.h>
#include <CoreGraphics/CoreGraphics.h>
class my_application : public sb6::application
{
public:
    void render(double currentTime)
    {
        static const GLfloat red[] ={1.0f,0.0f,0.0f,1.0f};
        glClearBufferfv(GL_COLOR,0,red);
    }
};

DECLARE_MAIN(my_application);