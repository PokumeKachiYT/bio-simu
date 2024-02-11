extends Camera3D

@onready var worldspace: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state

func on_click(position: Vector2) -> void:
	var start = project_ray_origin(position)
	var end = project_position(position,10000)
	var parameters = PhysicsRayQueryParameters3D.create(start,end,0)
	var result = worldspace.intersect_ray(parameters)
	print(result)

func _ready():
	pass

func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			on_click(event.position)
