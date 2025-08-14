extends CharacterBody2D

@export var move_speed : float = 100
@export var animater : AnimatedSprite2D
@export var is_gameover: bool = false
@export var bullet_scence : PackedScene


func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_gameover:
		$runningAudio.stop()
	elif not $runningAudio.playing:
		$runningAudio.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_gameover:
		velocity = Input.get_vector("left","right","up","down") * move_speed
		
		match velocity:
			Vector2.ZERO:
				animater.play("idle")
			_:
				animater.play("run") 
		move_and_slide()


func game_over():
	if !is_gameover:
		is_gameover = true
		animater.play("died")
		$deadAudio.play()
		get_tree().current_scene.show_game_over()
		
		$resetTimer.start()
		


func on_fire() -> void:
	if velocity != Vector2.ZERO or is_gameover:
		return
		
	$gunAudio.play()
	var bullet_node = bullet_scence.instantiate()
	bullet_node.position = position + Vector2(6, 6)
	get_tree().current_scene.add_child(bullet_node)


func reload_scene() -> void:
	get_tree().reload_current_scene()
