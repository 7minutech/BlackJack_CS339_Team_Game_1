extends Node2D

var active: bool
var description: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Functions to set and determine if this ability is an active ability or not
func setActive() -> void:
	active = true
func setPassive() -> void:
	active = false
func isActive() -> bool:
	return active

#Function to set the description of the ability
func setDescription(desc: String) -> void:
	description = desc

#Function to set the name of an ability
func setName(n: String) -> void:
	self.name = n

#Function to assign the correct ability sprite
func setSkin(sprite: CompressedTexture2D) -> void:
	$Skin.texture = sprite
