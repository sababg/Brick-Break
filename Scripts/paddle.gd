extends CharacterBody2D


@export var Speed = 300.0
const JUMP_VELOCITY = -400.0
var resetPos : Vector2

func _ready() -> void:
	resetPos = global_position


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity = Vector2(direction * Speed ,0 ) * delta
	else:
		velocity = Vector2(move_toward(velocity.x, 0, Speed) , 0 ) * delta

	position += velocity
	
func resetPosition () :
	global_position = resetPos
