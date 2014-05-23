//
//  main.m
//  DemoGL
//
//  Created by colin3dmax on 14-5-23.
//  Copyright (c) 2014年 colin3dmax. All rights reserved.
//

#include "sb6.h"
#include <iostream>
#include <string>
#include <cstdint>
#include <fstream>
#include <Foundation/Foundation.h>
#include <CoreGraphics/CoreGraphics.h>
using namespace std;
/*
 using Multi Shader App
*/
GLuint compile_shaders(void)
{
    GLuint vertex_shader;
    GLuint fragment_shader;
    GLuint program;
    
    //Source code for vertex shader
    ifstream is("vertex.glsl",std::ofstream::binary);
    string str;
    if(is){
        is.seekg(0,is.end);
        int length = is.tellg();
        is.seekg(0,is.beg);
        str.resize(length, ' ');
        char* begin = &*str.begin();
        is.read(begin, length);
        is.close();
        std::cout <<"----------vertex.glsl-----------\n";
        std::cout << str << "\n";
    }else{
        std::cout << "Could not open vertex.glsl\n";
    }
    const GLchar * vertex_shader_source =str.c_str();
    
    //Source code for fragment shader
    ifstream is2("fragment.glsl",std::ofstream::binary);
    string str2;
    if(is2){
        is2.seekg(0,is2.end);
        int length = is2.tellg();
        is2.seekg(0,is2.beg);
        str2.resize(length, ' ');
        char* begin = &*str2.begin();
        is2.read(begin, length);
        is2.close();
        
        std::cout <<"----------fragment.glsl-----------\n";
        std::cout << str2 << "\n";
    }else{
        std::cout << "Could not open fragment.glsl\n";
    }
    static const GLchar * frgament_shader_source=str2.c_str();
    
    //Create and compile vertex shader
    vertex_shader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource( vertex_shader,1,&vertex_shader_source,NULL);
    glCompileShader(vertex_shader);
    
    //Create and compile fragment shader
    fragment_shader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource( fragment_shader,1,&frgament_shader_source,NULL);
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
        
        GLfloat attrib[] = {
            (float)cos(currentTime)*0.5f+0.5f,
            (float)sin(currentTime)*0.5f+0.5f,
            0.0f,
            0.0f
        };
        glVertexAttrib4fv(0,attrib);
        
        GLfloat attrib2[] = {
            (float)cos(currentTime)*0.5f+0.5f,
            (float)sin(currentTime)*0.5f+0.5f,
            0.0f,
            0.0f
        };
        
        glVertexAttrib4fv(1,attrib2);
        
        glDrawArrays(GL_TRIANGLES,0,3);
    }
    
private:
    GLuint rendering_program;
    GLuint vertex_array_object;
};

DECLARE_MAIN(my_application);