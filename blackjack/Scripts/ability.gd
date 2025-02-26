extends Node2D

var active: bool
var description: String = "Placeholder Text"
var cooldown: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(self)
	print()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Function to set and determine if this ability is an active ability or not
func setStatus(status: String) -> void:
	if (status == "a") or (status == "A"):
		active = true
	elif (status == "P") or (status == "P'"):
		active = false

func isActive() -> bool:
	return active

#Function to set the description of the ability
func setDescription(desc: String) -> void:
	description = desc
#Function to set the cooldown of the ability
func setCooldown(cd: int) -> void:
	cooldown = cd

#Function to set the name of an ability
func setName(n: String) -> void:
	self.name = n

#Function to assign the correct ability sprite
func setSkin(sprite: CompressedTexture2D) -> void:
	$Skin.texture = sprite

func _to_string() -> String:
	return self.name + ": " + self.description + "\n" + "Active = " + str(self.active) + " Cooldown: " + str(self.cooldown)
