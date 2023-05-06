import * as THREE from 'three';

import { clock } from '../../core/clock';
import fragmentShader from './fragment.glsl';
import vertexShader from './vertex.glsl';

const torusGeometry = new THREE.TorusGeometry(250, 100, 16, 32);

/**
 * NOTE:
 *
 * モデル座標変換行列の逆行列を使用して、移動や回転を相殺する事もできるが（`this.material.uniforms.uInvMatrix.value = this.mesh.matrix.clone().invert()`）、
 * three.jsでは normalMatrix を使用でき、`normalMatrix * normal` でもともとの法線ベクトルに座標変換の結果を適用できるのでこちらを使う
 * ※ OrbitControlsを使う場合はそれぞれの挙動に差があることに注意
 */

export class DirectionalLightingSample {
  public readonly mesh: THREE.Mesh;
  private material: THREE.ShaderMaterial;
  constructor() {
    this.material = new THREE.ShaderMaterial({
      vertexShader,
      fragmentShader,
      side: THREE.DoubleSide,
      uniforms: {
        uTime: { value: 0 },
        uLightDirection: { value: new THREE.Vector3(-1, 1, -1) },
      },
    });
    this.mesh = new THREE.Mesh(torusGeometry, this.material);
  }
  public dispose() {
    this.material.dispose();
  }
  public update() {
    this.mesh.rotation.y += clock.delta / 1000;
    this.material.uniforms.uTime.value += clock.delta;
  }
}
