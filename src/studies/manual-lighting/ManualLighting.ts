import * as THREE from 'three';

import { clock } from '../../core/clock';
import fragmentShader from './fragment.glsl';
import vertexShader from './vertex.glsl';

const torusGeometry = new THREE.TorusGeometry(200, 75, 64, 64);

export class ManualLighting {
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
        uEyeDirection: { value: new THREE.Vector3(0, 0, -1) },
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
