uniform float uTime;
uniform vec3 uLightDirection;
uniform vec3 uEyeDirection;
varying vec2 vUv;
varying vec3 vNormal;
varying mat3 vNormalMatrix;

float wrapFloat(float value, float min, float max) {
  float range = max - min;
  return range + mod(value - min, range) + min;
}

vec3 hsv(float h, float s, float v) {
  vec4 t = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(vec3(h) + t.xyz) * 6.0 - vec3(t.w));
  return v * mix(vec3(t.x), clamp(p - vec3(t.x), 0.0, 1.0), s);
}

/**
 * ライティングをGLSLで表現する
 *
 * - 平行光源
 * - 環境光
 * - 反射光
 *
 * NOTE:
 * モデル座標変換行列の逆行列を使用して、移動や回転を相殺する事もできるが（`this.material.uniforms.uInvMatrix.value = this.mesh.matrix.clone().invert()`）、
 * three.jsでは normalMatrix を使用でき、`normalMatrix * normal` でもともとの法線ベクトルに座標変換の結果を適用できるのでこちらを使う
 * ※ OrbitControlsを使う場合はそれぞれの挙動に差があることに注意
 */

void main() {
  vec3 color = hsv(wrapFloat(uTime / 10000. + distance(vUv * .5, vec2(.25, .25)), 0., 1.), 1., 1.);
  vec4 ambientLightColor = vec4(.1, .1, .1, 1.);
  float directionalLightIntensity = .9;

  vec3 directionalLightDirection = normalize(uLightDirection);
  vec3 eyeDirection = normalize(uEyeDirection);

  vec3 normal = vNormalMatrix * vNormal;
  vec3 halfLE = normalize(directionalLightDirection + eyeDirection);
  float specular = pow(clamp(dot(normal, -halfLE), 0., 1.), 65.);
  float diffuse = clamp(dot(normal, -directionalLightDirection), 0., 1.);

  gl_FragColor = vec4(color * directionalLightIntensity * diffuse, 1.) + vec4(vec3(specular), 1.) + ambientLightColor;
}
