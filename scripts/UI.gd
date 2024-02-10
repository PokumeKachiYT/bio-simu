extends Control

var Slicer = MeshSlicer.new()
var SliceTransform = Transform3D().rotated(Vector3(1,0,0),deg_to_rad(90.0))
@onready var SliceSlider: VSlider = $Slicer
@onready var Model = get_node('SubViewportContainer/SubViewport/Mitochondrion')

var node_cache = []
var mesh_cache = []

func _ready():
	for i in range(Model.get_child_count()):
		var node: MeshInstance3D = Model.get_child(i)
		
		if node.name != 'Inner' and node.name != 'Outer':
			continue
		
		node_cache.append(node)
		mesh_cache.append(node.mesh)
	
	SliceSlider.connect('drag_ended',self.update_slice)

func update_slice(val_changed: bool):
	if not val_changed:
		return
	SliceTransform.origin.x = (SliceSlider.value - 50) / 50
	
	
	for i in range(mesh_cache.size()):
		var new_mesh = Slicer.slice_mesh(SliceTransform,mesh_cache[i])
		node_cache[i].mesh = new_mesh[0]
