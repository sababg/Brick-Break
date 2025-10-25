extends Node2D

var score = 0
@export var Lives = 3
var gameOver = false
var gameOverTimer = 3
@export var Levels: Array[PackedScene]
var levelIndex = -1
var currentLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UIManager/Lives.text = "Lives : " + str(Lives)
	spawnNewLevel()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gameOver : 
		gameOverTimer -= delta
		if gameOverTimer <= 0:
			$UIManager/GameOver/PressAnyKey.show() 
			if Input.is_anything_pressed():
				get_tree().reload_current_scene()
	pass

func addScore():
	score += 1
	$UIManager/Score.text = "Score : " + str(score)
	
func removeLife():
	Lives -= 1
	score = 0
	$UIManager/Lives.text = "Lives : " + str(Lives)
	$UIManager/Score.text = 'Score: ' + str(score)
	currentLevel.get_node("Paddle").resetPosition()
	if Lives <= 0:
		print("You lost")
		$UIManager/GameOver.show()
		$UIManager/GameOver/Score.text = 'Score: ' + str(score)
		gameOver = true
		$UIManager/GameOver/AnimationPlayer.play("puls")
		return 
		
	currentLevel.SpawnBall()


func spawnNewLevel():
	if currentLevel != null :
		currentLevel.queue_free()
	levelIndex += 1
	currentLevel = Levels[levelIndex].instantiate()
	currentLevel.LevelCompleted.connect(spawnNewLevel)
	currentLevel.AddScore.connect(addScore)
	currentLevel.RemoveLife.connect(removeLife)
	add_child(currentLevel)
	currentLevel.SpawnBall()
	
	
