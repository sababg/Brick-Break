extends RigidBody2D

@export var speed := 360
var velocity := Vector2(1,-1) * speed
signal AddScore
signal RemoveLife

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0
	linear_velocity = velocity

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	linear_velocity = linear_velocity.normalized() * speed
	
	if state.get_contact_count() > 0:
		for i in range(state.get_contact_count()):
			var collider = state.get_contact_collider_object(i)
			
			if collider.is_in_group("Brick"):
				collider.queue_free()
				AddScore.emit()
			if collider.is_in_group("Kill"):
				RemoveLife.emit()
				queue_free()
	
