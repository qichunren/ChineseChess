extends Node2D

var Chess = preload("res://Chess.tscn")
var chess_matrix = []
const COLUMNS = 9
const ROWS = 10

func _ready():
	for x in range(COLUMNS):
		var rows = []
		rows.resize(ROWS)
		chess_matrix.append(rows)
	chess_matrix[0][0] = "First"
	chess_matrix[0][1] = "Second"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	for x in range(COLUMNS):
		for y in range(ROWS):
			var c = chess_matrix[x][y]
			print(x, " ", y, " :", c)


func _on_swap_btn_pressed():
	var r = chess_matrix[0][0]
	chess_matrix[0][0] = chess_matrix[0][1]
	chess_matrix[0][1] = r
