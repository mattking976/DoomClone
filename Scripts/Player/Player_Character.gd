extends CharacterBody3D

#basic vars
const JUMP_VELOCITY = 4.5
const SPEED = 5.0
var playerVelocity = Vector3()
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var maxSpeed = 8
var mouseSensitivity = 0.002

#getting mouse input
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta):
	#adding gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	#handling jumping
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
 
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouseSensitivity)
		$Pivot.rotate_x(-event.relative.y * mouseSensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2) 

func change_gun(gun):
	pass

func _process(delta):
	pass
