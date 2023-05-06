attribute vec4 color;
varying vec4 vColor;
uniform vec3 uLightDirection;
uniform mat4 uInvMatrix;

void main() {
  vec3 invLight = normalize(uInvMatrix * -vec4(normalize(uLightDirection), 0.)).xyz;
  float diffuse = clamp(dot(normal, invLight), 0., 1.);
  vColor = color * vec4(vec3(diffuse), 1.);
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.);
}
