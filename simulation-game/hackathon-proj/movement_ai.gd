extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()



# Number of points to measure in the X and Y axes
var x_points := 100
var y_points := 100

# Define the angles (in degrees) for scanning along both axes
var x_angle_step := 180.0 / x_points
var y_angle_step := 180.0 / y_points

# Placeholder method to simulate depth measurement
var ray_dist := 0.0
func get_depth_at_point(x_angle: float, y_angle: float) -> float:
	#depth sensor measurement code
	if %RayCast.is_colliding():
		ray_dist = %RayCast.global_position.distance_to(%RayCast.get_collision_point()) 
	else:
		ray_dist = -1
	return ray_dist

func get_depth_grid() -> Array:
	var depth_grid := []
	for y in range(y_points):
		var row := []
		var y_angle := -90 + y * y_angle_step  # Scanning vertically from -90 to +90 degrees
		for x in range(x_points):
			var x_angle := -90 + x * x_angle_step  # Scanning horizontally from -90 to +90 degrees
			var distance := get_depth_at_point(x_angle, y_angle)
			
			row.append(distance)
		depth_grid.append(row)
	return depth_grid

# Call this function to start scanning and print out the results
func _ready():
	var depth_grid = get_depth_grid()
	for row in depth_grid:
		print(row)
