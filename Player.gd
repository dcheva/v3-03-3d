extends KinematicBody

# How fast the player moves in meters per second.
export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
# LERP delta

var velocity = Vector3.ZERO
var direction = Vector3.ZERO

func _physics_process(delta):
	
	var velocity_to = Vector3.ZERO
	var direction_to = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction_to.x += 1
	if Input.is_action_pressed("move_left"):
		direction_to.x -= 1
	if Input.is_action_pressed("move_back"):
		direction_to.z += 1
	if Input.is_action_pressed("move_forward"):
		direction_to.z -= 1

	direction_to = direction_to.normalized()
	direction = lerp(direction, direction_to, delta)
	
	$Pivot.look_at(translation + direction, Vector3.UP)

	velocity_to.x = direction.x * speed
	velocity_to.z = direction.z * speed
	velocity_to.y -= fall_acceleration * delta
	velocity = lerp(velocity, velocity_to, delta * 5)
	
	velocity = move_and_slide(velocity, Vector3.UP)
