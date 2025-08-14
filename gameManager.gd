extends Node2D

@export var slime_scence : PackedScene
@export var spawn_timer : Timer
@export var score : int = 0
@export var score_label : Label 
@export var game_over_label : Label 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawn_timer.wait_time = clamp(spawn_timer.wait_time, 1, 3)
	spawn_timer.wait_time -= 0.2 * delta
	score_label.text = "score: " + str(score)
	


func _spawn_slime() -> void:
	var slime_node = slime_scence.instantiate()
	slime_node.position = Vector2(260, randf_range(50, 115))
	get_tree().current_scene.add_child(slime_node)


func show_game_over():
	game_over_label.visible = true
	
	
func screen_shake(strength: float, duration: float):
	#获取活动相机
	var camera = get_viewport().get_camera_2d()
	if not camera:
		print("未找到相机")
		return
	
	#创建补间动画
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	
	#震动屏幕
	tween.tween_method(
		func(s: float):
			camera.offset = Vector2.from_angle(randf_range(0, TAU)) * s,
			strength,
			0.0,
			duration
	)
	
