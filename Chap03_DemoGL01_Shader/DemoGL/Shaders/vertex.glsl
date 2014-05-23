#version 400 core

//"offset" in an input vertex attribute
layout (location=0) in vec4 offset;
layout (location=1) in vec4 color;

out vec4 vs_color;

void main(void)                        
{                                      
   const vec4 vertices[3]=vec4[3]( 
   	vec4(0.25,-0.25,0.5,1.0),
   	vec4(-0.25,-0.25,0.5,1.0),
   	vec4(0.25,0.25,0.5,1.0)
   );

   //Add "offset" to out hard-coded vertex position
   gl_Position = vertices[gl_VertexID]+offset*0.5; 

   vs_color=color;
}            