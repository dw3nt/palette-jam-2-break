extends Control
class_name BaseMenu

signal room_ready
signal room_change_requested
signal music_change_requested

export(String, FILE, "*.tscn") var nextScene
export(TransitionsLoader.Transitions) var transition

var params : Dictionary = {}
