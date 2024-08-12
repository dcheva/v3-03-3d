extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO
var direction = Vector3.ZERO

func _ready():
	pass

func _physics_process(delta):
	# Using LERP vector 0
	var direction_to = Vector3.ZERO
	var velocity_to = Vector3.ZERO
	if Input.is_action_pressed("move_right"):
		direction_to.x += 1
	if Input.is_action_pressed("move_left"):
		direction_to.x -= 1
	if Input.is_action_pressed("move_back"):
		direction_to.z += 1
	if Input.is_action_pressed("move_forward"):
		direction_to.z -= 1
	
	if direction_to != Vector3.ZERO:
		# Direction
		direction_to = direction_to.normalized()
		# Ground velocity
		velocity_to.x = direction_to.x * speed
		velocity_to.z = direction_to.z * speed
		# Vertical velocity
		velocity_to.y -= fall_acceleration * delta

	# Applying LERP to vector 1
	direction = lerp(direction, direction_to, delta)
	velocity = lerp(velocity, velocity_to, delta)
	
	# Moving the character
	$Pivot.look_at(translation + direction, Vector3.UP)
	velocity = move_and_slide(velocity, Vector3.UP)
