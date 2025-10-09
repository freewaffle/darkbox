components {
  id: "script"
  component: "/assets/go/scripts/car.script"
}
components {
  id: "collision"
  component: "/assets/collision_objects/car.collisionobject"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"cartest\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas/go.atlas\"\n"
  "}\n"
  ""
  position {
    y: -80.0
    z: 1.5
  }
}
