extends Node2D

var Chess = preload("res://Chess.tscn")
var ChessMarker = preload("res://ChessMarker.tscn")

var chess_matrix = []

const COLUMNS = 9
const ROWS = 10

var selected_chess = null
var player_team = "black"
var player_turn = "red"

func _ready():
	for x in range(COLUMNS):
		var rows = []
		rows.resize(ROWS)
		chess_matrix.append(rows)
	#print(chess_matrix)
	spawn_chess()
	if player_turn == player_team:
		$turn_tip_0.visible = true
		$turn_tip_1.visible = false
	else:
		$turn_tip_0.visible = false
		$turn_tip_1.visible = true
	#print(chess_matrix)

func spawn_chess():
	# var id_names = ["Advisor", "Cannon", "Chariot", "Elephant", "General", "Horse", "Soldier"]
	if player_team == "red":
		layout_chess("Soldier", "red", 0, 3)
		layout_chess("Soldier", "red", 2, 3)
		layout_chess("Soldier", "red", 4, 3)
		layout_chess("Soldier", "red", 6, 3)
		layout_chess("Soldier", "red", 8, 3)
		layout_chess("General", "red", 4, 0) # Master
		layout_chess("Advisor", "red", 3, 0)
		layout_chess("Advisor", "red", 5, 0)
		layout_chess("Elephant", "red", 2, 0)
		layout_chess("Elephant", "red", 6, 0)
		layout_chess("Horse", "red", 1, 0)
		layout_chess("Horse", "red", 7, 0)
		layout_chess("Chariot", "red", 0, 0)
		layout_chess("Chariot", "red", 8, 0)
		layout_chess("Cannon", "red", 1, 2)
		layout_chess("Cannon", "red", 7, 2)
	
		layout_chess("Soldier", "black", COLUMNS-1-0, ROWS-1-3)
		layout_chess("Soldier", "black", COLUMNS-1-2, ROWS-1-3)
		layout_chess("Soldier", "black", COLUMNS-1-4, ROWS-1-3)
		layout_chess("Soldier", "black", COLUMNS-1-6, ROWS-1-3)
		layout_chess("Soldier", "black", COLUMNS-1-8, ROWS-1-3)
		layout_chess("General", "black", COLUMNS-1-4, ROWS-1-0) # Master
		layout_chess("Advisor", "black", COLUMNS-1-3, ROWS-1-0)
		layout_chess("Advisor", "black", COLUMNS-1-5, ROWS-1-0)
		layout_chess("Elephant", "black", COLUMNS-1-2, ROWS-1-0)
		layout_chess("Elephant", "black", COLUMNS-1-6, ROWS-1-0)
		layout_chess("Horse", "black", COLUMNS-1-1, ROWS-1-0)
		layout_chess("Horse", "black", COLUMNS-1-7, ROWS-1-0)
		layout_chess("Chariot", "black", COLUMNS-1-0, ROWS-1-0)
		layout_chess("Chariot", "black", COLUMNS-1-8, ROWS-1-0)
		layout_chess("Cannon", "black", COLUMNS-1-1, ROWS-1-2)
		layout_chess("Cannon", "black", COLUMNS-1-7, ROWS-1-2)
	else:
		layout_chess("Soldier", "black", 0, 3)
		layout_chess("Soldier", "black", 2, 3)
		layout_chess("Soldier", "black", 4, 3)
		layout_chess("Soldier", "black", 6, 3)
		layout_chess("Soldier", "black", 8, 3)
		layout_chess("General", "black", 4, 0) # Master
		layout_chess("Advisor", "black", 3, 0)
		layout_chess("Advisor", "black", 5, 0)
		layout_chess("Elephant", "black", 2, 0)
		layout_chess("Elephant", "black", 6, 0)
		layout_chess("Horse", "black", 1, 0)
		layout_chess("Horse", "black", 7, 0)
		layout_chess("Chariot", "black", 0, 0)
		layout_chess("Chariot", "black", 8, 0)
		layout_chess("Cannon", "black", 1, 2)
		layout_chess("Cannon", "black", 7, 2)
	
		layout_chess("Soldier", "red", COLUMNS-1-0, ROWS-1-3)
		layout_chess("Soldier", "red", COLUMNS-1-2, ROWS-1-3)
		layout_chess("Soldier", "red", COLUMNS-1-4, ROWS-1-3)
		layout_chess("Soldier", "red", COLUMNS-1-6, ROWS-1-3)
		layout_chess("Soldier", "red", COLUMNS-1-8, ROWS-1-3)
		layout_chess("General", "red", COLUMNS-1-4, ROWS-1-0) # Master
		layout_chess("Advisor", "red", COLUMNS-1-3, ROWS-1-0)
		layout_chess("Advisor", "red", COLUMNS-1-5, ROWS-1-0)
		layout_chess("Elephant", "red", COLUMNS-1-2, ROWS-1-0)
		layout_chess("Elephant", "red", COLUMNS-1-6, ROWS-1-0)
		layout_chess("Horse", "red", COLUMNS-1-1, ROWS-1-0)
		layout_chess("Horse", "red", COLUMNS-1-7, ROWS-1-0)
		layout_chess("Chariot", "red", COLUMNS-1-0, ROWS-1-0)
		layout_chess("Chariot", "red", COLUMNS-1-8, ROWS-1-0)
		layout_chess("Cannon", "red", COLUMNS-1-1, ROWS-1-2)
		layout_chess("Cannon", "red", COLUMNS-1-7, ROWS-1-2)
	for x in range(COLUMNS):
		for y in range(ROWS):
			var c = chess_matrix[x][y]
			if not is_instance_valid(c):
				layout_marker(x, y)
	
func clear_chesses():
	for x in range(COLUMNS):
		for y in range(ROWS):
			var c = chess_matrix[x][y]
			if is_instance_valid(c):
				chess_matrix.erase(c)
				c.queue_free()
				chess_matrix[x][y] = null

# 移动棋子到目标点位
func move_chess(chess, target_x, target_y):
	var p = $board_origin.position
	var text_size = chess.texture_normal.get_size()
	if target_x >= 0 and target_y >= 0:
		var c = chess_matrix[target_x][target_y]
		print("c type name:", c.type_name)
		if c.type_name == "ChessMarker": # 棋子光标
			# 将目标位置上的光标移动到棋子的位置，然后将棋子移动到光标的位置
			c.set_x_y_value(chess.x_value, chess.y_value)
			print("Set marker position to new: ", c.x_value, " - ", c.y_value)
			c.set_position(Vector2(p.x + c.x_value*53-text_size.x/2, p.y - c.y_value*53 - text_size.y/2))
			chess_matrix[chess.x_value][chess.y_value] = c
			print("..................", chess.x_value, "   ", chess.y_value)
		elif c.type_name == "Chess":
			print("To be done.") # 吃子
			#print("target is chess", c.name)
			#c.set_x_y_value(chess.x_value, chess.y_value)
			#chess_matrix[chess.x_value][chess.y_value] = c
			#print("Set position:")
			#c.set_position(Vector2(p.x + chess.x_value*53-text_size.x/2, p.y - chess.y_value*53 - text_size.y/2))
			#print("Set position end.")
			layout_marker(chess.x_value, chess.y_value)
			chess_matrix.erase(c)
			c.queue_free()
		#yield(get_tree().create_timer(0.1), "timeout")
		chess_matrix[target_x][target_y] = chess
		chess.set_x_y_value(target_x, target_y)
		chess.set_position(Vector2(p.x + target_x*53-text_size.x/2, p.y - target_y*53 - text_size.y/2))
	else:
		chess.set_position(Vector2(p.x + chess.x_value*53-text_size.x/2, p.y - chess.y_value*53 - text_size.y/2))
	
func layout_chess(id_name, team, x, y):
	var chess = Chess.instance()
	chess.set_x_y_value(x, y)
	chess_matrix[x][y] = chess
	chess.set_id_name(id_name, team)
	move_chess(chess, -1, -1)
	add_child(chess)
	chess.connect("pressed", self, "_on_chess_pressed", [chess])

func layout_marker(x, y):
	var marker = ChessMarker.instance()
	marker.set_x_y_value(x, y)
	chess_matrix[x][y] = marker
	add_child(marker)
	marker.connect("pressed", self, "_on_marker_pressed", [marker])
	var p = $board_origin.position
	var text_size = Vector2(32, 32)
	marker.set_position(Vector2(p.x + x*53-text_size.x/2, p.y - y*53 - text_size.y/2))

func _on_chess_pressed(chess):
	#print("chess pressed: ", chess.x_value, " - ", chess.y_value)
	if selected_chess == null and chess.team != player_turn:
		print("..1")
		return
	if selected_chess == null:
		print("..2")
		chess.selected_mark.visible = true
		selected_chess = chess
		update_chess_valid_positions(chess)	
	if selected_chess == chess:
		return
		
	if chess.team == player_turn:
		print("..3")
		selected_chess.selected_mark.visible = false		
		selected_chess = chess
		selected_chess.selected_mark.visible = true
		update_chess_valid_positions(chess)	
	else:
		print("..4")
		if can_move(selected_chess, chess.x_value, chess.y_value):
			move_chess(selected_chess, chess.x_value, chess.y_value)
			selected_chess.selected_mark.visible = false
			selected_chess = null
			if player_turn == "red":
				player_turn = "black"
			else:
				player_turn = "red"
			if player_turn == player_team:
				$turn_tip_0.visible = true
				$turn_tip_1.visible = false
			else:
				$turn_tip_0.visible = false
				$turn_tip_1.visible = true
		else:
			print("Invalid movement.")

func _on_marker_pressed(marker):
	print("marker pressed: ", marker.x_value, " - ", marker.y_value)
	if selected_chess != null and player_turn == selected_chess.team:
		if can_move(selected_chess, marker.x_value, marker.y_value):
			move_chess(selected_chess, marker.x_value, marker.y_value)
			selected_chess.selected_mark.visible = false
			selected_chess = null
			if player_turn == "red":
				player_turn = "black"
			else:
				player_turn = "red"
			if player_turn == player_team:
				$turn_tip_0.visible = true
				$turn_tip_1.visible = false
			else:
				$turn_tip_0.visible = false
				$turn_tip_1.visible = true
		else:
			print("Invalid movement.")

func can_move(chess, x, y):
	if x == chess.x_value and y == chess.y_value:
		return false
	var c = chess_matrix[x][y]
	if is_instance_valid(c):
		if c.type_name == "Chess" and c.team == chess.team:
			return false

		if chess.id_name == "Soldier": # 卒子
			print("ssssss")
			if chess.team == player_team:
				if y < 5: # 下方卒子还没有过河
					if y == chess.y_value + 1 and x == chess.x_value:
						return true
					else:
						return false
				else:
					if y == chess.y_value and (x == chess.x_value - 1 or x == chess.x_value + 1):
						return true
					elif x == chess.x_value and y == chess.y_value + 1:
						return true
					else:
						return false
			else:
				if y > 4: # 上方卒子还没有过河
					if y == chess.y_value - 1 and x == chess.x_value:
						return true
					else:
						return false
				else:
					if y == chess.y_value and (x == chess.x_value - 1 or x == chess.x_value + 1):
						return true
					elif x == chess.x_value and y == chess.y_value - 1:
						return true
					else:
						return false
		elif chess.id_name == "Chariot": # 车
			if x == chess.x_value or y == chess.y_value:
				if x == chess.x_value:
					if y > chess.y_value:
						for n in range(chess.y_value, y):
							print("y:", n)
					else:
						for n in range(y, chess.y_value):
							print("y:", n)
				return true
			else:
				return false
		else:
			return false
			

	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var clicked_p = get_global_mouse_position()
		#clear_chesses()		
		#print(chess_matrix)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_play_btn_pressed():
	for x in range(COLUMNS):
		for y in range(ROWS):
			var c = chess_matrix[x][y]
			if is_instance_valid(c):
				print(x, " - ", y, " :", c.type_name, " -> ", c.x_value, " - ", c.y_value)
	
func update_chess_valid_positions(chess):
	if chess.id_name == "Soldier":
		var new_y = chess.y_value + 1
		var c = chess_matrix[chess.x_value][new_y]
		
		
	else:
		pass
