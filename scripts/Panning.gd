extends Node3D

const SENSITIVITY = 0.25

@onready var CameraHandler: Node3D = $CameraHandler2
@onready var Camera: Camera3D = CameraHandler.get_node('Camera')

func _ready():
	pass

var lerp_dir = 0.0

func _process(delta):
	var zoom_amount = delta * 5 + lerp_dir * 5
	if Input.is_action_just_released('zoom_in'):
		Camera.transform.origin.z -= zoom_amount
		lerp_dir = lerp(lerp_dir,1.0,min(delta * 5,1))
	elif Input.is_action_just_released('zoom_out'):
		Camera.transform.origin.z += zoom_amount
		lerp_dir = lerp(lerp_dir,1.0,min(delta * 5,1))
	else:
		lerp_dir = lerp(lerp_dir,0.0,min(delta,1))
	
	Camera.transform.origin.z = clamp(Camera.transform.origin.z,2.5,45.0)

func _input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed('rotate'):
		#rotation_degrees.y += event.relative.x
		#rotation_degrees.x += event.relative.y
		rotate_y(-deg_to_rad(event.relative.x * SENSITIVITY))
		CameraHandler.rotate_x(-deg_to_rad(event.relative.y * SENSITIVITY))
