extends KinematicBody2D


export (float) var MAX_SPEED = 200
export (float) var ACCELERATION = 2000


var velocity = Vector2()

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready() -> void:
	Globals.Player = self
	animationTree.active = true
	animationState.travel("IDLE")


func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector.normalized()
	return input_vector
	
func update_position(delta: float, input_vector: Vector2) -> void:
	velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	
func update_animation_tree_blend_space(input_vector: Vector2) -> void:
	animationTree.set("parameters/IDLE/blend_position", input_vector)
	animationTree.set("parameters/WALK/blend_position", input_vector)
	animationTree.set("parameters/ATTACK/blend_position", input_vector)	

func update_animation_tree(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		animationState.travel("IDLE")
	else:
		update_animation_tree_blend_space(input_vector)
		animationState.travel("WALK")
		

func _process(delta: float) -> void:
	if animationState.get_current_node() != "ATTACK":
		var input_vector = get_input_vector()
		update_position(delta, input_vector)
		update_animation_tree(input_vector)
	
	if Input.is_action_just_pressed("attack"):
		animationState.travel("ATTACK")
		
	if Input.is_action_just_pressed("player_menu"):
		if Globals.UI_Menu.visible:
			Globals.UI_Menu.hide()
		else:
			Globals.UI_Menu.show()
	
	
