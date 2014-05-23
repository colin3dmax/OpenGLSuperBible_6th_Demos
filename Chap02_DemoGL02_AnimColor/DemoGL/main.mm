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
//Animating color over time app
class my_application : public sb6::application
{
public:
    void render(double currentTime)
    {
        float r=(float)sin(currentTime)*0.5f+0.5f;
        float g=(float)cos(currentTime)*0.5f+0.5f;
        float b=1.0f;
        float a=1.0f;
        NSLog(@"%f,%f,%f,%f",r,g,b,a);
        const GLfloat color[] ={r,g,b,a};
        glClearBufferfv(GL_COLOR,0,color);
    }
};

DECLARE_MAIN(my_application);