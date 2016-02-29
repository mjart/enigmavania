//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
#define PI 3.14159265358
#define TAU (2.0 * PI)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_time;
uniform float u_intensity;

void main()
{
    const vec2 crR = vec2(-0.7071067812, -0.7071067812);
    const vec2 crG = vec2(0.7071067812, -0.7071067812);
    const vec2 crB = vec2(0.0, 1.0);
    
    float cosrot = cos(u_time * 2.0 * PI);
    float sinrot = sin(u_time * 2.0 * PI);
    
    vec2 rR = vec2(cosrot * crR.x - sinrot * crR.y, sinrot * crR.x + cosrot * crR.y) * u_intensity;
    vec2 rG = vec2(cosrot * crG.x - sinrot * crG.y, sinrot * crG.x + cosrot * crG.y) * u_intensity;
    vec2 rB = vec2(cosrot * crB.x - sinrot * crB.y, sinrot * crB.x + cosrot * crB.y) * u_intensity;
    
    vec2 pctEffect = vec2(1);//(v_vTexcoord - vec2(0.5)) * 2.0;
    
    vec3 aberrationX = vec3(rR.x / 1024.0, rG.x / 1024.0, rB.x / 1024.0) * pctEffect.x;
    vec3 aberrationY = vec3(rR.y / 768.0, rG.y / 768.0, rB.y / 768.0) * pctEffect.y;

    vec2 waveOffset = 0.03 * vec2(
        sin(u_time + v_vTexcoord.y * TAU),
        sin(u_time + PI + v_vTexcoord.x * TAU));
    
#if 0
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
#else
    float r = texture2D(gm_BaseTexture, v_vTexcoord + vec2(aberrationX.x, aberrationY.x) + waveOffset).r;
    float g = texture2D(gm_BaseTexture, v_vTexcoord + vec2(aberrationX.y, aberrationY.y) + waveOffset).g;
    float b = texture2D(gm_BaseTexture, v_vTexcoord + vec2(aberrationX.z, aberrationY.z) + waveOffset).b;
    
    //r += texture2D(gm_BaseTexture, v_vTexcoord + vec2(-aberrationX.x, -aberrationY.x)).r * .5;
    //g += texture2D(gm_BaseTexture, v_vTexcoord + vec2(-aberrationX.y, -aberrationY.y)).g * .5;
    //b += texture2D(gm_BaseTexture, v_vTexcoord + vec2(-aberrationX.z, -aberrationY.z)).b * .5;

    gl_FragColor = vec4(r,g,b, 1);// * vec4(1,0,1,1);
    
#endif
}

