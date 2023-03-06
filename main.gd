extends Node

signal potion_brewed(potion)

@export var potion_scene: PackedScene
var active_potion

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/BrewButton.hide()
	$HUD/PotionSelection.hide()
	game_screen_setup()
#	$Player.gain_experience(550)


func game_screen_setup():
	$HUD/BrewButton.show()
	$HUD/PotionSelection.show()
	$ActivePotion.position = $ActivePotion/ActivePotionMarker.position
	refresh_potion_selection()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$DevelopmentHUD/GenericLeft.text =  "GenericLabelTimer: " + str(round_place($HUD/GenericLabelTimer.time_left, 2))
	$DevelopmentHUD/GenericLeft.text += "\nPotion Skill XP: " + str($Player.potion_exp) + "\nPotion Skill Next XP: "  + str($Player.potion_next_exp) + "\nPotion Skill Total XP: " + str($Player.potion_total_exp)
	$DevelopmentHUD/GenericLeft.text += "\nLeveling Array: ["
	var max_level = 20
	for x in range(2,max_level):
		$DevelopmentHUD/GenericLeft.text += "(" + str(x) + ":" + str($Player.get_required_potion_experience(x)) + ") "
	$DevelopmentHUD/GenericLeft.text += "]"
	
	if $HUD.menu_selection == "LevelInfo":
		$HUD/RightMenuText.text = "Level: " + str($Player.potion_skill)
		$HUD/RightMenuText.text += "\nXP: " + str($Player.potion_exp) + "/" + str($Player.potion_next_exp) + "\nTotal: " + str($Player.potion_total_exp)


func _on_hud_brew_button_pressed():
	if active_potion:
		$ActivePotion.shake(.5)
		active_potion.count += 1
		$HUD.set_generic_label("+" + str($Player.get_xp_payout(active_potion.difficulty)), 1)
		emit_signal("potion_brewed", active_potion)
	else:
		$HUD.set_generic_label("No potion selected!", 2)


func _on_hud_potion_toggled(potion):
	if $Player.can_brew(potion.difficulty):
		print("player can brew")
		active_potion = potion
		$ActivePotion.set_sprite_frames(potion.sprite_frames)
	else:
		print("player cannot brew!")
#		$HUD.set_generic_label("Sorry! You need level " + str(potion.get_node("PotionStats").difficulty) + "to do that", 4)


func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
	
	
func refresh_potion_selection():
	for node in $HUD/PotionSelection.get_children():
		pass
		if !$Player.can_brew(node.difficulty):
			node.disable()
			print(str(node.difficulty))
		else:
			node.enable()
		


func _on_player_potion_skill_level_up():
	refresh_potion_selection()
