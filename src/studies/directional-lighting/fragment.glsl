uniform vec3 uLightDirection;
varying vec3 vNormal;
varying vec2 vUv;
uniform float uTime;

float wrapFloat(float value, float min, float max) {
  float range = max - min;
  return range + mod(value - min, range) + min;
}

vec3 hsv(float h, float s, float v) {
  vec4 t = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(vec3(h) + t.xyz) * 6.0 - vec3(t.w));
  return v * mix(vec3(t.x), clamp(p - vec3(t.x), 0.0, 1.0), s);
}

void main() {
  vec4 ambientColor = vec4(.2, .2, .2, 1.);
  vec3 directionalColor = hsv(wrapFloat(uTime / 10000. + distance(vUv * .5, vec2(.25, .25)), 0., 1.), 1., 1.);
  float intensity = .9;
  float diffuse = clamp(dot(vNormal, -normalize(uLightDirection)), 0., 1.);
  gl_FragColor = vec4(directionalColor * intensity * diffuse, 1.) + ambientColor;
}
