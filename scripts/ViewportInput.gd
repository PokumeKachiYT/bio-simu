extends SubViewportContainer

@onready var viewport: SubViewport = $SubViewport
@onready var worldspace: PhysicsDirectSpaceState3D = viewport.world_3d.direct_space_state

func on_click() -> void:
	var start = project_ray_origin()

func _ready():
	pass

func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			on_click(event.global_position)
