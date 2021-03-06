extends Node

################################################################################
#### Variables
var camera_start: Vector2 = Vector2.ZERO setget set_camera_start, get_camera_start
var last_door_closed := {}
var main_control := Settings.GAMEPAD
var volumes := {"main_volume": 0.0, "music_volume": -8.0, "sfx_volume": 0.0}
var screen := {"resolution": Vector2(960, 540), "full_screen": false}

var user = {"type": "", "name": ""}
var testers = ["QATester", "Tester"]
var bug_testers = ["QATester"]
var performers = ["Tester", "Jugador"]
var players = ["Jugador"]
var log_id := 0
var game_id := 0
var current_slot := "slot_1"
var scene_to_load := ""

var player_state = {
	"respawn_position": Vector2.ZERO,
	"last_state": "Init",
	"current_room": "Room1",
	"last_room": "Room0",
	"current_room_version": 1,
	"last_room_version": 1,
	"current_level": {"level_name": "", "level_number": 0},
	"next_level": ""
	}
################################################################################

################################################################################
#### Setters y Getters
func set_user(utype: String, uname: String) -> void:
	user["type"] = utype
	user["name"] = uname

func get_user():
	return user

func set_log_id(value: int) -> void:
	log_id = value

func get_log_id() -> int:
	return log_id

func set_game_id(value: int) -> void:
	game_id = value

func get_game_id() -> int:
	return game_id

func set_scene_to_load(value: String) -> void:
	scene_to_load = value

func get_scene_to_load() -> String:
	return scene_to_load

func set_player_last_state(value: String) -> void:
	player_state["last_state"] = value

func get_player_last_state() -> String:
	return player_state["last_state"]

func set_player_respawn_position(value: Vector2) -> void:
	player_state["respawn_position"] = value

func get_player_respawn_position() -> Vector2:
	return player_state["respawn_position"]

func set_player_current_room(value: String, version: int) -> void:
	player_state["current_room"] = value
	player_state["current_room_version"] = version

func get_player_current_room() -> String:
	return player_state["current_room"]

func get_player_current_room_int() -> int:
	return int(player_state["current_room"].substr(4,-1))

func get_player_last_room_int() -> int:
	return int(player_state["last_room"].substr(4,-1))

func get_player_current_room_v() -> int:
	return player_state["current_room_version"]

func set_player_last_room(value: String, version: int) -> void:
	player_state["last_room"] = value
	player_state["last_room_version"] = version

func get_player_last_room() -> String:
	return player_state["last_room"]

func get_player_last_room_v() -> int:
	return player_state["last_room_version"]

func set_player_current_level(name: String, number: int) -> void:
	player_state["current_level"]["level_name"] = name
	player_state["current_level"]["level_number"] = number

func get_player_current_level_name() -> String:
	return player_state["current_level"]["level_name"]

func get_player_current_level_number() -> String:
	return player_state["current_level"]["level_number"]

func set_player_next_level(value: String) -> void:
	player_state["next_level"] = value

func get_player_next_level() -> String:
	return player_state["next_level"]

func set_camera_start(value: Vector2) -> void:
	camera_start = value

func get_camera_start() -> Vector2:
	return camera_start

func set_last_door_closed(door: String, room: String) -> void:
	last_door_closed = {'door': door, 'room': room}

func clear_last_door_closed() -> void:
	last_door_closed = {}

func get_last_door_closed() -> Dictionary:
	return last_door_closed

func get_main_controls() -> int:
	return main_control

func set_main_controls(value: int) -> void:
	main_control = value

func get_volumes(bus: String) -> float:
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))

func set_volumes(bus: String, value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), value)

func change_volume(bus: String, value: float, addition: bool) -> void:
	var old_volume := AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus))
	if addition:
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(bus),
			old_volume + value
			)
	else:
		AudioServer.set_bus_volume_db(
			AudioServer.get_bus_index(bus),
			old_volume - value
			)

func set_current_slot(value: String) -> void:
	current_slot = value

func get_current_slot() -> String:
	return current_slot

func get_screen() -> Dictionary:
	return screen

func set_screen(resolution: Vector2, full: bool) -> void:
	screen.resolution = resolution
	screen.full_screen = full
################################################################################

################################################################################
func reset_data() -> void:
	set_player_respawn_position(Vector2.ZERO)
	set_player_current_level("", 0)
	set_player_current_room("Room1", 1)
	set_player_last_state("Init")

func init_level() -> void:
	set_camera_start(Vector2.ZERO)
	clear_last_door_closed()
	set_player_current_room("Room1", 1)
	set_player_respawn_position(Vector2.ZERO)
	set_player_last_state("Init")

func print_user_data() -> void:
	print(user)
	print("log: ", log_id)
	print("Controller: ", main_control)
	print("Main_Volume: {mv} - Music_Volume: {sm} - SFX_volume: {sv}".format({"mv": volumes.main_volume, "sm": volumes.music_volume, "sv": volumes.sfx_volume}))
	print("Resolucion: {res} - Full Screen: {f}".format({"res": screen.resolution, "f": screen.full_screen}))


