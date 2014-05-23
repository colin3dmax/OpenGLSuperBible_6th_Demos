#version 400 core
in VS_OUT
{
	vec4 color;	// Send color to the next stage
} fs_in;

out vec4 color;           
void main(void)                   
{                                 
   color = fs_in.color;
}                                 
