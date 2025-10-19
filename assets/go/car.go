components {
  id: "script"
  component: "/assets/go/scripts/car.script"
}
components {
  id: "collision"
  component: "/assets/collision_objects/car/collision.collisionobject"
}
components {
  id: "danger"
  component: "/assets/collision_objects/car/danger.collisionobject"
}
components {
  id: "car"
  component: "/assets/sprites/car.sprite"
  position {
    y: -80.0
    z: 1.5
  }
}
components {
  id: "engine"
  component: "/assets/sounds/engine1.sound"
}
components {
  id: "asphsound"
  component: "/assets/sounds/asphmove.sound"
}
