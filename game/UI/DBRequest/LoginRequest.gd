extends Node

signal done

onready var LoginRequest := get_node("LoginRequest")
onready var LoginResult = []


func _ready() -> void:
	LoginRequest.connect("request_completed", self, "_LoginRequest_request_completed")

func Login(user :String, password :String) -> void:
	var headers = ["Content-Type: application/json"]
	var query = JSON.print({"nickname": user, "password": password})
	LoginRequest.request("http://142.93.201.7:3000/login", headers, false, HTTPClient.METHOD_POST, query)

func _LoginRequest_request_completed(_result, response_code, _headers, body) -> void:
	var json = JSON.parse(body.get_string_from_utf8())
	if response_code == 200:
		LoginResult = [response_code, json.result['Tipo']]
	elif response_code == 401:
		LoginResult = [response_code, json.result]
	else:
		var msj = "Error %s on database connection" % response_code
		LoginResult = [response_code, msj]
	
	emit_signal("done")
