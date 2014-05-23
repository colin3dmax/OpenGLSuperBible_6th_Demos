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
/*
 using Shader App
*/
GLuint compile_shaders(void)
{
    GLuint vertex_shader;
    GLuint fragment_shader;
    GLuint program;
    
    //Source code for vertex shader
    static const GLchar * vertex_shader_source[] ={
            "#version 400 core                          \n"
            "                                           \n"
            "void main(void)                            \n"
            "{                                          \n"
            "   gl_Position = vec4(0.0,0.0,0.5,1.0);    \n"
            "}                                          \n"
    };
    //Source code for fragment shader
    static const GLchar * frgament_shader_source[]={
        "#version 400 core                          \n"
        "out vec4 color;                            \n"
        "void main(void)                            \n"
        "{                                          \n"
        "   color = vec4(1.0,0.0,0.0,1.0);          \n"
        "}                                          \n"
    };
    
    //Create and compile vertex shader
    vertex_shader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource( vertex_shader,1,vertex_shader_source,NULL);
    glCompileShader(vertex_shader);
    
    //Create and compile fragment shader
    fragment_shader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource( fragment_shader,1,frgament_shader_source,NULL);
    glCompileShader(fragment_shader);
    
    //Create program, attach shaders to it ,and link it
    program = glCreateProgram();
    glAttachShader(program,vertex_shader);
    glAttachShader(program,fragment_shader);
    glLinkProgram(program);
    
    //Delete the shaders as the program has them now
    glDeleteShader(vertex_shader);
    glDeleteShader(fragment_shader);
    
    return program;
    
}

class my_application : public sb6::application
{
public:
    void startup()
    {
        rendering_program = compile_shaders();
        glGenVertexArrays(1,&vertex_array_object);
        glBindVertexArray(vertex_array_object);
    }
    
    void shutdown()
    {
        glDeleteVertexArrays(1,&vertex_array_object);
        glDeleteProgram(rendering_program);
        glDeleteVertexArrays(1,&vertex_array_object);
    }
    
    void render(double currentTime)
    {
        float r=(float)sin(currentTime)*0.5f+0.5f;
        float g=(float)cos(currentTime)*0.5f+0.5f;
        float b=1.0f;
        float a=1.0f;
        //NSLog(@"%f,%f,%f,%f",r,g,b,a);
        const GLfloat color[] ={r,g,b,a};
        
        glClearBufferfv(GL_COLOR,0,color);
        
        //Use the program object we create earlier for rndering
        glUseProgram(rendering_program);
        //Draw one point
        glPointSize(sin(currentTime)*200.0f);
        glDrawArrays(GL_POINTS,0,1);
    }
    
private:
    GLuint rendering_program;
    GLuint vertex_array_object;
};

DECLARE_MAIN(my_application);