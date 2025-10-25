extends Node2D
class_name LevelManager
var bricks = []
signal LevelCompleted 
@export var Ball: PackedScene
signal AddScore
signal RemoveLife

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bricks = get_tree().get_nodes_in_group("Brick")
	for i in bricks:
		i.tree_exited.connect(func(): self.onBrickExit(i))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func onBrickExit(brick):
	bricks.erase(brick)
	if bricks.size() <= 0:
		LevelCompleted.emit()
		
func SpawnBall():
	var currentBall = Ball.instantiate()
	currentBall.global_position =get_tree().get_nodes_in_group("BallSpawnPoint")[0].global_position
	add_child(currentBall)
	currentBall.AddScore.connect(func(): AddScore.emit())
	currentBall.RemoveLife.connect(func(): RemoveLife.emit())
