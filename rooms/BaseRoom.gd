extends Node2D
class_name BaseRoom

signal room_ready
signal room_change_requested
signal music_change_requested

export(String, FILE, "*.tscn") var nextScene
export(TransitionsLoader.Transitions) var transition

var params : Dictionary = {}
