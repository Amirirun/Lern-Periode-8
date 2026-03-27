extends Node

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")

var db
var db_name = "res://DataStore/database.db"

var snake
var window_border
var apple_count = 0
var player_id = 1
var highscore = 0


func _ready():
	init_db()
	ensure_player_exists()
	load_highscore()

	window_border = OS.get_window_size()
	var classLoad = load("res://Scripts/Snake.gd")
	snake = classLoad.new()
	draw_apple()
	$apple.visible = true

	print("Spiel gestartet | Highscore: ", highscore)


func init_db():
	db = SQLite.new()
	db.path = db_name

	if db.open_db():
		print("DB verbunden: ", db_name)
	else:
		print("Fehler: Datenbank konnte nicht geöffnet werden")


func ensure_player_exists():
	if db == null:
		return

	db.query("SELECT * FROM PlayerInfo WHERE ID = " + str(player_id) + ";")

	if db.query_result.size() == 0:
		var dict = {}
		dict["ID"] = player_id
		dict["Name"] = "Navid"
		dict["Score"] = 0
		db.insert_row("PlayerInfo", dict)
		print("Player erstellt")
	else:
		print("Player existiert bereits")


func load_highscore():
	if db == null:
		return

	db.query("SELECT Score FROM PlayerInfo WHERE ID = " + str(player_id) + ";")

	if db.query_result.size() > 0:
		highscore = int(db.query_result[0]["Score"])
	else:
		highscore = 0

	print("Geladener Highscore: ", highscore)


func update_highscore_in_db():
	if db == null:
		return

	if apple_count > highscore:
		highscore = apple_count
		db.query("UPDATE PlayerInfo SET Score = " + str(highscore) + " WHERE ID = " + str(player_id) + ";")
		print("Neuer Highscore gespeichert: ", highscore)
	else:
		print("Highscore bleibt: ", highscore)


func get_random_pos_for_apple():
	randomize()
	var x = (randi() % 20) * snake.width
	var y = (randi() % 20) * snake.width
	return Vector2(x, y)


func draw_apple():
	var new_rand_pos = get_random_pos_for_apple()

	for block in snake.body:
		if block == new_rand_pos:
			new_rand_pos = get_random_pos_for_apple()
			continue
		if block == snake.body[snake.body.size() - 1]:
			$apple.position = new_rand_pos


func draw_snake():
	if snake.body.size() > $snake.get_child_count():
		var lastChilde = $snake.get_child($snake.get_child_count() - 1).duplicate()
		lastChilde.name = "body " + str($snake.get_child_count())
		$snake.add_child(lastChilde)

	for index in range(0, snake.body.size()):
		$snake.get_child(index).rect_position = snake.body[index]


func is_apple_colide():
	if snake.body[0] == $apple.position:
		return true
	return false


func _input(_event):
	if Input.is_action_pressed("ui_right") and not snake.direction == Vector2(-snake.width, 0):
		snake.direction = Vector2(snake.width, 0)
	elif Input.is_action_pressed("ui_left") and not snake.direction == Vector2(snake.width, 0):
		snake.direction = Vector2(-snake.width, 0)
	elif Input.is_action_pressed("ui_down") and not snake.direction == Vector2(0, -snake.width):
		snake.direction = Vector2(0, snake.width)
	elif Input.is_action_pressed("ui_up") and not snake.direction == Vector2(0, snake.width):
		snake.direction = Vector2(0, -snake.width)


func is_game_over():
	if snake.body[0].x < 0 or snake.body[0].x > window_border.x - snake.width:
		return true
	elif snake.body[0].y < 0 or snake.body[0].y > window_border.y - snake.width:
		return true

	if snake.body.size() >= 3:
		for block in snake.body.slice(1, snake.body.size()):
			if snake.body[0] == block:
				return true

	return false


func _on_Timer_timeout():
	if is_game_over():
		update_highscore_in_db()
		print("Game Over! Punkte: ", apple_count, " | Highscore: ", highscore)
		get_tree().reload_current_scene()
		return

	snake.move()
	draw_snake()

	if is_apple_colide():
		$AudioStreamPlayer2D.play()
		apple_count += 1

		if apple_count > highscore:
			highscore = apple_count
			db.query("UPDATE PlayerInfo SET Score = " + str(highscore) + " WHERE ID = " + str(player_id) + ";")
			print("Neuer Highscore erreicht: ", highscore)
		else:
			print("Punkte: ", apple_count, " | Highscore: ", highscore)

		draw_apple()
		snake.is_apple_colide = true
