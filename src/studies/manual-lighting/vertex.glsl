varying vec2 vUv;
varying vec3 vNormal;
varying mat3 vNormalMatrix;

void main() {
  vNormal = normal;
  vNormalMatrix = normalMatrix;
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.);
}
