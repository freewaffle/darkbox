components {
  id: "mission"
  component: "/assets/go/scripts/mission.script"
}
components {
  id: "script"
  component: "/assets/go/scripts/player.script"
}
components {
  id: "collision"
  component: "/assets/collision_objects/player.collisionobject"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"player_1\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "size {\n"
  "  x: 360.0\n"
  "  y: 360.0\n"
  "}\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/atlas/go.atlas\"\n"
  "}\n"
  ""
  position {
    z: 1.0
  }
  scale {
    x: 0.2
    y: 0.2
  }
}
