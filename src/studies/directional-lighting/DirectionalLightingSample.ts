import * as THREE from 'three';

import { clock } from '../../core/clock';
import fragmentShader from './fragment.glsl';
import vertexShader from './vertex.glsl';

const torusGeometry = new THREE.TorusGeometry(250, 100, 16, 32);

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
        uInvMatrix: { value: new THREE.Matrix4() },
        uLightDirection: { value: new THREE.Vector3(0, 0, -1) },
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
    this.material.uniforms.uInvMatrix.value = this.mesh.matrix.clone().invert();
  }
}
