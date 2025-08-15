extends Area2D

@export var slime_speed : float = -30
var is_dead : bool = false
@export var hp : float = 30

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
		#销毁子弹对象
		area.queue_free()
		#扣血
		hp -= area.damage
		
		#血量清零：死亡
		if hp == 0 or hp < 0 and !is_dead:
			is_dead = true
			$AnimatedSprite2D.play("death")
			get_tree().current_scene.score += 1
			$deathAudio.play()
			await get_tree().create_timer(0.6).timeout
			queue_free()
		#还有血量，被击退并且显示击退特效
		else:
			hp -= area.damage
			position -= Vector2(-3, 0)
			$HitFlash.flash()
		
	
