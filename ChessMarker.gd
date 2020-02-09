extends TextureButton

var x_value = 0
var y_value = 0
var type_name = "ChessMarker"

func _ready():
	pass # Replace with function body.

func set_x_y_value(x, y):
	x_value = x
	y_value = y

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ChessMarker_mouse_entered():
	print("Hovered marker: ", x_value, " - ", y_value)
