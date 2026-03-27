extends Spatial

const SQLite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_name = "res://DataStore/database"

# Called when the node enters the scene tree for the first time.
func _ready():
	commitDataToDB()
	pass # Replace with function body.


func commitDataToDB():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "PlayerInfo"
	var dict : Dictionary = Dictionary()
	dict["Name"] = "this is a test user"
	dict["Score"] = 5000

	db.insert_row(tableName,dict)
