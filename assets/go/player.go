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
components {
  id: "sprite"
  component: "/assets/sprites/player.sprite"
  position {
    z: 1.0
  }
  scale {
    x: 0.2
    y: 0.2
  }
}
components {
  id: "shadow"
  component: "/assets/sprites/sphere_shadow.sprite"
}
