
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float scale = 3.0;


float dist(in vec2 _st, in vec2 _mouse){
  float d = abs(_st.x -_mouse.x);
  return d;
}

void main() {
  vec2 st = gl_FragCoord.xy/u_resolution;
  vec3 color = vec3(0.0);

  vec2 mouse = u_mouse/u_resolution;
  
  //Escala en función de la escala adoptada solo en X
  st.x = fract(st.x*scale); 
    
  // invierte las posiciones de la mitad de abajo para
  // generar formas simétricas respecto al eje X
  if( st.y > 0.5) st.y = 1. - st.y;
  
  if( mouse.y > 0.5 ) mouse.y = 1. - mouse.y;
  
  float steps = 12.;
  // "floor(steps*dist(st, mouse))/(steps*2)" es para discretizar la distancia con el ratón y generar una "escalera"
  // "(mouse.y)*1.1*fract(u_time)" provoca que la escalera se contraiga de forma ciclica hasta la altura donde está el ratón
  float bottom = step(floor(steps*dist(st, mouse))/(steps*2) + (mouse.y)*1.1*fract(u_time), st.y);
  float left = 1;
  float pct = left*bottom; // left AND bottom (como left es 1 es igual a bottom)
  
  color = vec3(pct);
  
  if( pct > 0){ // si no es negro se le asigna un color turquesa
    color = vec3(0,250,154);
  }


  gl_FragColor = vec4(color,1.0);
}
