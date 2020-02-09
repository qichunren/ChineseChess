extends TextureButton

var type_name = "Chess"
var team = "red" # Or black
var id_name = ""
var x_value = 0
var y_value = 0
var valid_positions = []

onready var selected_mark = $selected_mark

func _ready():
	pass
	
func set_id_name(value, value2):
	self.id_name = value
	self.team = value2
	if value2 == "red":
		self.texture_normal = Global.textures_red[value]
	else:
		self.texture_normal = Global.textures_black[value]
		
func set_x_y_value(x, y):
	x_value = x
	y_value = y
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Chess_mouse_entered():
	print("Hovered chess(", id_name, ") : ", x_value, " - ", y_value)
	self.rect_scale = Vector2(1.1, 1.1)

func _on_Chess_mouse_exited():
	self.rect_scale = Vector2(1.0, 1.0)
	
func update_valid_positions():
	pass	
