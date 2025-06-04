extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var character: CharacterBody2D = $character
@onready var character_shape: RectangleShape2D = $character/CollisionShape2D.shape

func get_character_edges():
	var character = $character
	var shape = character.get_node("CollisionShape2D").shape as RectangleShape2D
	var offset = character.get_node("CollisionShape2D").position
	var center_x = character.global_position.x + offset.x
	var half_width = shape.size.x * 0.5

	var left = center_x - half_width
	var right = center_x + half_width

	return [left, right]

func _process(delta):
	var screen_width = get_viewport().size.x
	var camera_center_x = camera.global_position.x
	var screen_left = camera_center_x - screen_width * 0.5
	var screen_right = camera_center_x + screen_width * 0.5
	
	var edges = get_character_edges()
	var left_edge = edges[0]
	var right_edge = edges[1]
