//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform vec2 cpos;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 pos;

void main()
{
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    pos = vec2(in_Position.x - cpos.x, in_Position.y - cpos.y);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 pos;

uniform float d;

void main()
{
    vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    float grey = (col.x + col.y + col.z) / 3.0;
    
    float dist = pos.x * pos.x + pos.y * pos.y;
    if(dist < d * d){
        gl_FragColor = vec4(col.x * 1.2, col.y * 1.2, col.z * 1.2, col.w);
    }else{
        gl_FragColor = col;
    }
}

