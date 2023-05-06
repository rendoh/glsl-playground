import 'the-new-css-reset';

import { clock } from './core/clock';
import { renderer } from './core/renderer';
import { sizes } from './core/sizes';
import { ManualLighting } from './studies/manual-lighting/ManualLighting';

sizes.addEventListener('resize', resize);
clock.addEventListener('tick', update);

const example = new ManualLighting();
renderer.scene.add(example.mesh);

function resize() {
  renderer.resize();
}

function update() {
  example.update();
  renderer.update();
}
