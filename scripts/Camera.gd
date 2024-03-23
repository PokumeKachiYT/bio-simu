extends Camera3D

const SENSITIVITY = 0.25

@onready var worldspace: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state
@onready var rotation_handler = get_parent()
@onready var rotation_handler2 = rotation_handler.get_parent()
var mouse_position = Vector2.ZERO
var hovering_target = null

func hover() -> void:
	var start = project_ray_origin(mouse_position)
	var end = project_position(mouse_position,10000)
	var parameters = PhysicsRayQueryParameters3D.create(start,end)
	parameters.hit_from_inside = true
	var result = worldspace.intersect_ray(parameters)
	
	if result and result.has('collider'):
		hovering_target = result.collider.get_parent()

func _process(delta):
	var zoom_amount = .05#delta * 5
	var new_zoom = transform.origin.z
	
	if Input.is_action_just_released('zoom_in') and transform.origin.z > 1:
		new_zoom -= zoom_amount
	elif Input.is_action_just_released('zoom_out') and transform.origin.z < 100:
		new_zoom += zoom_amount
	
	if new_zoom < 1:
		new_zoom = 1
	elif new_zoom > 100:
		new_zoom = 100
	
	transform.origin.z = new_zoom
	
	#hover()
	
	#print(hovering_target.name)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pass
	if event is InputEventMouseMotion and Input.is_action_pressed('pan'):
		var basis = rotation_handler2.transform.basis * rotation_handler.transform.basis
		
		var relative = event.relative * 0.001
		var offset = basis.x * -relative.x + basis.y * relative.y
		global_position += offset
	if event is InputEventMouse:
		mouse_position = event.position
