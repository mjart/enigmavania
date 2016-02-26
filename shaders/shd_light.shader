//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vTexcoord =  in_TextureCoord;
    v_vColour = in_Colour;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_color;
uniform float u_scale;

#define QUADRA 0.9
#define LINEAR (1.0 - QUADRA)

void main()
{
    vec2 pos2D = v_vColour.xw * 2.0 - vec2(1.0);
    float dist = length(pos2D) * u_scale;
    float atten = max(0.0, (1.0 / (1.0 + dist * dist)) - dist * LINEAR);
        
    vec3 col = u_color * atten;

    gl_FragColor = vec4(col, 1.0);
}

