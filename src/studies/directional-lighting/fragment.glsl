uniform vec3 uLightDirection;
varying vec3 vNormal;

void main() {
  float diffuse = clamp(dot(vNormal, -uLightDirection), 0., 1.);
  gl_FragColor = vec4(vec3(diffuse), 1.);
}
