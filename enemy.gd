extends Area2D

@export var slime_speed : float = -30
var is_dead : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_dead:
		position += Vector2(slime_speed, 0) * delta
		
	if position.x < -267:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_dead:
		body.game_over()
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('bullet'):
		$AnimatedSprite2D.play("death")
		is_dead = true
		
		get_tree().current_scene.screen_shake(2, 0.2)
		area.queue_free()
		get_tree().current_scene.score += 1
		$deathAudio.play()
		await get_tree().create_timer(0.6).timeout
		queue_free()
		
	
