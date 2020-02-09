extends Node

var textures_red = {}
var textures_black = {}


func _ready():
	print("Global init.")
	var names = ["Advisor", "Cannon", "Chariot", "Elephant", "General", "Horse", "Soldier"]
	for name in names:
		var img = load("res://chess_assets/%s.png" % name)
		var t0 = AtlasTexture.new()
		t0.atlas = img
		t0.region = Rect2(0, 0, 36, 36)
		textures_red[name] = t0
		var t1 = AtlasTexture.new()
		t1.atlas = img
		t1.region = Rect2(38, 0, 36, 36)
		textures_black[name] = t1
